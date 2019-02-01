#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=WEBSITE-TIER2-BIZLOGIC

cd sonar-ldap
mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic"
cd -
curl -X POST -u $SQ_TOKEN: $SQ_URL/api/project_tags/set?project=$PK&tag=superbank.com
