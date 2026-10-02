#!/bin/bash

PR=$1

if [ "$PR" = "" ] || [ "$PR" = "-h" ] || [ "$PR" = "-?" ]; then
   echo "Usage: $0 <pull-request-number>"
   echo ""
   echo "Analyzes the pr-demo branch as a pull request against the main branch."
   echo "Requires Developer Edition or above, and a local or remote pr-demo branch."
   exit 1
fi

# Load common environment
. ../sqlib.sh

# Check out the branch holding the pull request code
git fetch origin pr-demo 2>/dev/null
git checkout pr-demo || git checkout origin/pr-demo || exit 1

sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN \
   -Dsonar.pullrequest.branch=pr-demo -Dsonar.pullrequest.key=$PR \
   -Dsonar.pullrequest.base=master
