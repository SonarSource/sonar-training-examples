#!/bin/bash

# Load common environment
. ../../sqlib/sh

PK=BANK-RETAIL-401K

mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=BANK-RETAIL-401K -Dsonar.projectName="Retail Banking - 401K"

# Tag project
curl -X POST -u $SQ_TOKEN: $SQ_URL/api/project_tags/set?project=$PK&tag=superbank.com
