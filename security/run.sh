#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:security"

echo "Deleting project"
curl -X POST -u $SQ_TOKEN: $SQ_HOST/api/projects/delete?project=$PK

echo "Running analysis"
mvn clean verify sonar:sonar -Dsonar.host.url=$SQ_HOST -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK
