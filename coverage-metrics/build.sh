#!/bin/bash

# Load common environment
. ../sqlib.sh

for branch in master partial-coverage partial-coverage-2 issue-on-test-files
do
	git checkout $branch
	branchOpt=""
	if [ "$branch" != "master" ]; then
		branchOpt="-Dsonar.branch.name=$branch"
	fi
	mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install org.jacoco:jacoco-maven-plugin:report \
		-Dmaven.test.failure.ignore=true \
		sonar:sonar $branchOpt \
		-Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN \
		-Dsonar.exclusions=pom.xml \
		-Dsonar.projectKey="training:coverage" -Dsonar.projectName="Training: Coverage" $*
done
# Return to master branch after analysis of other branches
git checkout master
