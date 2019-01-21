
#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:pull-request"

# Delete existing project
curl -X POST -u $SQ_TOKEN: $SQ_URL/api/projects/delete?project=$PK

# Scan initial master branch
git checkout master
sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK
