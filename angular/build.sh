#!/bin/bash

# Set SQ environment
. ../sqlib.sh

npm install

# use Angular CLI to trigger a test run so we have coverage data
./node_modules/.bin/ng test --code-coverage

# call the sonar scanner
sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN
