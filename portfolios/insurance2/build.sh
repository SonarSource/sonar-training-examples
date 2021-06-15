#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=$(cat sonar-project.properties | grep sonar.projectKey | sed 's/^.*sonar.projectKey=//')

sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK

curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$PK&tag=superbank.com"
