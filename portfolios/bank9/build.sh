#!/bin/bash

# Load common environment
. ../../sqlib/sh

PK=BANK-RETAIL-401K

mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=BANK-RETAIL-401K -Dsonar.projectName="Retail Banking - 401K"

# Tag project
curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$PK&tag=superbank.com"
