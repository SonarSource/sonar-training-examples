#!/bin/bash
PK="training:security"

if [ "$SQ_URL" != "" ]; then
   sqHostOpt="-Dsonar.host.url=$SQ_URL"
fi
if [ "$TOKEN" != "" ]; then
   sqLoginOpt="-Dsonar.login=$TOKEN"
fi

echo "Deleting project"

curl -X POST -u $sqHostOpt $sqLoginOpt $SQ_URL/api/projects/delete?project=$PK

echo "Creating project"
mvn clean verify sonar:sonar $sqHostOpt $sqLoginOpt
