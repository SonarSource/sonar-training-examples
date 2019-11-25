#!/bin/bash

npm install

# use Angular CLI to trigger a test run so we have coverage data
./node_modules/.bin/ng test --code-coverage

# call the sonar scanner
sonar-scanner
