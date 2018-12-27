#!/bin/bash
PK="training:security"
HOST=http://localhost:9000


if [ "$SQ_URL" != "" ]; then
   HOST=$SQ_URL
fi

sqHostOpt="-Dsonar.host.url=$HOST"

if [ "$TOKEN" != "" ]; then
   sqLoginOpt="-Dsonar.login=$TOKEN"
   echo "Deleting project"
   curl -X POST -u $TOKEN: $HOST/api/projects/delete?project=$PK
fi

echo "Running analysis"
mvn clean verify sonar:sonar $sqHostOpt $sqLoginOpt
