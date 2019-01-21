#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=$(cat sonar-project.properties | grep sonar.projectKey | sed 's/^.*sonar.projectKey=//')

sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK

curl -X POST -u $SQ_TOKEN: $SQ_URL/api/project_tags/set?project=$PK&tag=superbank.com
