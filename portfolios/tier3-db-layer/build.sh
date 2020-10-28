#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=$(cat sonar-project.properties | grep sonar.projectKey | sed 's/^.*sonar.projectKey=//')


sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK
sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK -Dsonar.branch.name=release-2019.4
sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK -Dsonar.branch.name=release-2020.1

curl -X POST -u $SQ_TOKEN: "$SQ_URL/api/project_tags/set?project=$PK&tags=superbank.com"
