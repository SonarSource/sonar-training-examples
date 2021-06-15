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

mvn clean install -P coverage sonar:sonar  \
    -Dsonar.projectKey="K21949"  \
    -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN \

    #-Dsonar.projectVersion=afterMerge
    #-Dsonar.pullrequest.key=81 -Dsonar.pullrequest.branch=test21929

exit $?
