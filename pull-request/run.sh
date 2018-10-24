
#!/bin/bash

FILE="src/app.js"
PK="training:pull-request"
BRANCH="feature/pull-request"
PR="feature-pr"
PARAMS="-Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN"

# Delete existing project
curl -X POST -u $TOKEN: $SQ_URL/api/projects/delete?project=$PK

cp $FILE.orig $FILE

# Scan initial master branch
sonar-scanner $PARAMS

# Switch to pr-demo branch
git checkout -b $PR
cp $FILE.mod $FILE

#Commit and push branch
git commit
git request-pull $BRANCH ./
