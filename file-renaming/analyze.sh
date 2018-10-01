#!/bin/bash

# Scan with project containing class HelloWorld in package helloworld
sonar-scanner -Dsonar.projectVersion=1.0 

# Rename package, rename and move file
./rename.sh

# Scan again, change version to create a leak
sonar-scanner -Dsonar.projectVersion=2.0 

# On 5.6.x you should see all issues as new, on 6.7 all issues remain in the legacy, 0 new issues
