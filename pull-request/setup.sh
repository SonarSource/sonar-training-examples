#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:pull-request"

# Delete existing project
curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/projects/delete?project=$PK

# Scan the main branch, which the pull request will be compared against
git checkout master
sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK
