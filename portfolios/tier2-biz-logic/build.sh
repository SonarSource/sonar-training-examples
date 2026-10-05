#!/bin/bash

# Load common environment
. ../../sqlib.sh

# Read projectKey from sonar-project.properties
PK=WEBSITE-TIER2-BIZLOGIC

cd sonar-ldap
mvn clean install -Dlicense.skip=true

# Run scan
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-1.1
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-2019.4
mvn org.sonarsource.scanner.maven:sonar-maven-plugin:5.8.0.7211:sonar -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK -Dsonar.projectName="Bank Web Site: Tier 2 - Biz Logic" -Dsonar.branch.name=release-2020.1
cd -
curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$PK&tags=superbank.com"
