#!/bin/bash

# Load common environment
. ../sqlib.sh

PK="training:security-cs"

doScan() {
  dotnet sonarscanner begin /d:sonar.host.url=$SQ_URL /k:$PK /n:"C# Security Training Example"
  dotnet build My_API.sln
  dotnet sonarscanner end
}

pushd My_API

echo "Deleting project"
curl -X POST -u $SQ_TOKEN: $SQ_URL/api/projects/delete?project=$PK

echo "Running initial project scan"
doScan

echo "Simulating change that introduces vulnerabilities"
pushd My_API/Controllers
cp ValuesController.cs ValuesController.cs.orig
cp ValuesController.cs.newCode ValuesController.cs 
popd

echo "Running follow-up project scan"
doScan

# restore things as they were 
pushd My_API/Controllers
mv ValuesController.cs.orig ValuesController.cs 
popd

popd
