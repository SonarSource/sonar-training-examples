#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:security"

echo "Deleting project"
curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/projects/delete?project=$PK

echo "Running analysis"
mvn clean verify sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK \
   -Dsonar.scm.disabled=true -X \
   -Dsonar.security.sources.javasecurity.S3649=s3649JavaSqlInjectionConfig.json \
   -Dsonar.security.sanitizers.javasecurity.S3649=s3649JavaSqlInjectionConfig.json \
   -Dsonar.security.sinks.javasecurity.S3649=s3649JavaSqlInjectionConfig.json
