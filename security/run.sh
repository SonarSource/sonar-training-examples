#!/bin/bash
PK="training:security"
HOST=http://localhost:9000


if [ "$SQ_URL" != "" ]; then
   HOST=$SQ_URL
fi

sqHostOpt="-Dsonar.host.url=$SQ_URL"

if [ "$TOKEN" != "" ]; then
   sqLoginOpt="-Dsonar.login=$TOKEN"
   echo "Deleting project"
   curl -X POST $curlLoginOpt $HOST/api/projects/delete?project=$PK
fi

echo "Running analysis"
mvn clean verify sonar:sonar $sqHostOpt $sqLoginOpt
