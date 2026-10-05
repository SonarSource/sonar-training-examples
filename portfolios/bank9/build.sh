#!/bin/bash

# Load common environment
. ../../sqlib.sh

PK=BANK-RETAIL-401K

mvn clean install -Dlicense.skip=true

# Run scan
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Retail Banking - 401K"

# Tag project
curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$PK&tags=superbank.com"
