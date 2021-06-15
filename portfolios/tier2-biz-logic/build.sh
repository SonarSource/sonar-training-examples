#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=WEBSITE-TIER2-BIZLOGIC

cd sonar-ldap
mvn clean install

# Run scan
mvn sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-1.1
mvn sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-2019.4
mvn sonar:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-2020.1
cd -
curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$PK&tags=superbank.com"
