
#!/bin/bash

PR=$1
PR_NAME=$2
PARAMS="-Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN"

# Scan initial master branch
# git checkout origin/pr-demo

sonar-scanner $PARAMS -Dsonar.pullrequest.branch=$PR_NAME -Dsonar.pullrequest.key=$PR
