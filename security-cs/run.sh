#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:security-cs"

doScan() {
  dotnet sonarscanner begin /d:sonar.host.url=$SONAR_HOST_URL /k:$PK /n:"C# Security Training Example" /d:sonar.token=$SONAR_TOKEN
  dotnet build My_API.sln
  dotnet sonarscanner end /d:sonar.token=$SONAR_TOKEN
}

cd My_API || exit 1

echo "Deleting project"
curl -X POST --silent --output /dev/null --show-error -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/projects/delete?project=$PK"

echo "Running initial project scan"
doScan

echo "Simulating change that introduces vulnerabilities"
cp Controllers/ValuesController.cs Controllers/ValuesController.cs.orig
cp Controllers/ValuesController.cs.newCode Controllers/ValuesController.cs
mv Controllers/ValuesDao.cs.newCode Controllers/ValuesDao.cs

echo "Running follow-up project scan"
doScan

# restore things as they were
mv Controllers/ValuesController.cs.orig Controllers/ValuesController.cs
mv Controllers/ValuesDao.cs Controllers/ValuesDao.cs.newCode
