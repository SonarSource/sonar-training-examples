
#!/bin/bash

PR=$1

# Load common environment
. ../sqlib.sh

# Scan initial master branch
git checkout origin/pr-demo

sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.pullrequest.branch=pr-demo -Dsonar.pullrequest.key=$PR
