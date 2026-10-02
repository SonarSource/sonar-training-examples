#!/bin/bash

DETEKT_JAR=linters/detekt-cli-1.23.8-all.jar
CHECKSTYLE_JAR=linters/checkstyle-14.3.0-all.jar

REPORTS_DIRECTORY=reports

[ ! -d "$REPORTS_DIRECTORY" ] && mkdir $REPORTS_DIRECTORY

# A missing linter would otherwise leave an empty report behind, and the scan would quietly
# import nothing at all for that language.
require() {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "ERROR: $1 not found. $2" >&2
		exit 1
	fi
}

require java "Install a JDK to run checkstyle and detekt."
require pylint "Install it with: pip install pylint"
require golangci-lint "Install it from https://golangci-lint.run/welcome/install/"

echo "Running checkstyle on Java code"
java -jar $CHECKSTYLE_JAR -c /sun_checks.xml src/java/HelloWorld.java -f xml | grep -v "Checkstyle ends with" >$REPORTS_DIRECTORY/checkstyle-report.xml

echo "Running pylint on Python code"
pylint src/python/sonarqube -r n --msg-template="{path}:{line}: [{msg_id}({symbol}), {obj}] {msg}" > $REPORTS_DIRECTORY/pylint-report.txt

echo "Running golangci-lint on Go code"
# Every file in src/go is a standalone "package main" with its own main(), so the directory
# does not typecheck as one package and golangci-lint would report nothing but redeclaration
# errors. Linting one file at a time avoids that, at the cost of having to stitch the
# per-file checkstyle documents back into a single report.
GO_REPORT=$REPORTS_DIRECTORY/golangci-lint-report.xml
{
	echo '<?xml version="1.0" encoding="UTF-8"?>'
	echo '<checkstyle version="5.0">'
	for gofile in src/go/*.go; do
		golangci-lint run --output.checkstyle.path stdout --output.text.path "" "$gofile" 2>/dev/null |
			sed -n '/<file /,/<\/file>/p'
	done
	echo '</checkstyle>'
} >$GO_REPORT

echo "Running detekt on Kotlin code"
# Generate config file and move in "gitignored" reports directory
java -jar $DETEKT_JAR --generate-config --config $REPORTS_DIRECTORY/default-detekt-config.yml
# Generate detekt report
java -jar $DETEKT_JAR --config $REPORTS_DIRECTORY/default-detekt-config.yml --input src/kt --report xml:$REPORTS_DIRECTORY/detekt-report.xml
