
#!/bin/bash

PK="training:pull-request"
PARAMS="-Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN"

# Delete existing project
curl -X POST -u $TOKEN: $SQ_URL/api/projects/delete?project=$PK

# Scan initial master branch
git checkout master
sonar-scanner $PARAMS
