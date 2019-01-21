#!/bin/bash

DETEKT_JAR=linters/detekt-cli-1.0.0-RC12-all.jar
CHECKSTYLE_JAR=linters/checkstyle-8.16-all.jar

REPORTS_DIRECTORY=reports

[ ! -d "$REPORTS_DIRECTORY" ] && mkdir $REPORTS_DIRECTORY

echo "Running checkstyle on Java code"
java -jar $CHECKSTYLE_JAR -c /sun_checks.xml src/java/HelloWorld.java -f xml | grep -v "Checkstyle ends with" >reports/checkstyle-report.xml

echo "Running pylint on Python code"
pylint src/python/sonarqube -r n --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" > $REPORTS_DIRECTORY/pylint-report.txt

echo "Running golint on Go code"
golint src/go/ >$REPORTS_DIRECTORY/golint-report.txt

echo "Running detekt on Kotlin code"
# Generate config file and move in "gitignored" reports directory
java -jar $DETEKT_JAR -gc; mv default-detekt-config.yml reports
# Generate detekt report
java -jar $DETEKT_JAR -c reports/default-detekt-config.yml -i src/kt -r xml:$REPORTS_DIRECTORY/detekt-report.xml
