#!/bin/bash

# Load common environment
. ../sqlib.sh

if [ "$1" = "-h" ] || [ "$1" = "-?" ]; then
	echo "Usage: $0 [-h|-?] [<scanner-properties>]"
	echo ""
	echo "Example: $0 -Dsonar.host.url=http://localhost:9000"
	exit 0
fi

mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install \
   -Dmaven.test.failure.ignore=true \
   sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN \
   -Dsonar.exclusions=pom.xml \
   -Dsonar.projectKey=training:size-metrics \
   $*

exit $?
