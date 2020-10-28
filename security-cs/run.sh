#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:security-cs"

doScan() {
  dotnet sonarscanner begin /d:sonar.host.url=$SONAR_HOST_URL /k:$PK /n:"C# Security Training Example" /d:sonar.login=$SONAR_TOKEN
  dotnet build My_API.sln
  dotnet sonarscanner end /d:sonar.login=$SONAR_TOKEN
}

pushd My_API

echo "Deleting project"
curl -X POST -u $SONAR_TOKEN: $SONAR_URL/api/projects/delete?project=$PK

echo "Running initial project scan"
doScan

echo "Simulating change that introduces vulnerabilities"
pushd My_API/Controllers
cp ValuesController.cs ValuesController.cs.orig
cp ValuesController.cs.newCode ValuesController.cs
mv ValuesDao.cs.newCode ValuesDao.cs
popd

echo "Running follow-up project scan"
doScan

# restore things as they were
pushd My_API/Controllers
mv ValuesController.cs.orig ValuesController.cs
mv ValuesDao.cs ValuesDao.cs.newCode
popd

popd
