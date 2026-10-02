#!/bin/bash

DETEKT_JAR=linters/detekt-cli-1.23.8-all.jar
CHECKSTYLE_JAR=linters/checkstyle-14.3.0-all.jar

REPORTS_DIRECTORY=reports

[ ! -d "$REPORTS_DIRECTORY" ] && mkdir $REPORTS_DIRECTORY

echo "Running checkstyle on Java code"
java -jar $CHECKSTYLE_JAR -c /sun_checks.xml src/java/HelloWorld.java -f xml | grep -v "Checkstyle ends with" >$REPORTS_DIRECTORY/checkstyle-report.xml

echo "Running pylint on Python code"
pylint src/python/sonarqube -r n --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" > $REPORTS_DIRECTORY/pylint-report.txt

echo "Running golint on Go code"
# golint is deprecated by the Go team but still installable, and unlike golangci-lint
# it lints loose .go files that are not part of a module:
#   go install golang.org/x/lint/golint@latest
golint src/go/ >$REPORTS_DIRECTORY/golint-report.txt

echo "Running detekt on Kotlin code"
# Generate config file and move in "gitignored" reports directory
java -jar $DETEKT_JAR --generate-config --config $REPORTS_DIRECTORY/default-detekt-config.yml
# Generate detekt report
java -jar $DETEKT_JAR --config $REPORTS_DIRECTORY/default-detekt-config.yml --input src/kt --report xml:$REPORTS_DIRECTORY/detekt-report.xml
