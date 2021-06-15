
#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:pull-request"

# Delete existing project
curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/projects/delete?project=$PK

# Scan initial master branch
git checkout master
sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK
