#!/bin/bash

# Set SQ environment
. ../sqlib.sh

npm install

# use Angular CLI to trigger a test run so we have coverage data
# --watch=false so Karma exits instead of waiting for file changes
./node_modules/.bin/ng test --code-coverage --watch=false

# call the sonar scanner
sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN
