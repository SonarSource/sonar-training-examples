#!/bin/bash

# Load common environment
. ../sqlib.sh

# Scan with project containing class HelloWorld in package helloworld
sonar-scanner -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectVersion=1.0 

# Rename package, rename and move file
./rename.sh

# Scan again, change version to start a new code period
sonar-scanner  -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectVersion=2.0 

# All issues keep their history across the rename, so there are 0 new issues

# Rename back, so the working tree is left the way we found it
./rename.sh
