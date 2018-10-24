
#!/bin/bash

PR=$1
PARAMS="-Dsonar.host.url=$SQ_URL -Dsonar.login=$TOKEN"

# Scan initial master branch
git checkout origin/pr-demo

sonar-scanner $PARAMS -Dsonar.pullrequest.branch=pr-demo -Dsonar.pullrequest.key=$PR
