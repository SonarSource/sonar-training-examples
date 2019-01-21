#!/bin/bash

# Load common environment
. ../sqlib.sh

testFile="src/test/java/coverage_metrics/CoverageMetricsTest.java"

if [ "$1" = "-h" ] || [ "$1" = "-?" ]; then
	echo "Usage: $0 [-h|-?] [1|2|all] [<scanner-properties>]"
	echo "1: Run only UT1"
	echo "2: Run only UT2"
	echo "all: Run all UT"
	echo ""
	echo "Example: $0 all -Dsonar.host.url=http://localhost:9673"
	exit 0
elif [ "$1" = "1" ] || [ "$1" = "2" ] || [ "$1" = "all" ]; then
	ut=$1
	shift
	cp $testFile.ut$ut $testFile
fi

mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install \
   -Dmaven.test.failure.ignore=true \
   sonar:sonar -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN \
   -Dsonar.exclusions=pom.xml \
   -Dsonar.projectKey="training:test-ut$ut" -Dsonar.projectName="Training: Coverage UT $ut" $*

exit $?
