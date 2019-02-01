
#!/bin/bash

PR=$1

# Load common environment
. ../sqlib.sh

# Scan initial master branch
git checkout origin/pr-demo

sonar-scanner -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.pullrequest.branch=pr-demo -Dsonar.pullrequest.key=$PR
