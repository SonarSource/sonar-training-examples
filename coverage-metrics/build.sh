#!/bin/bash

# Load common environment
. ../sqlib.sh

# This script checks out other branches of this repository, so remember where we started
startingBranch=$(git rev-parse --abbrev-ref HEAD)

for branch in master partial-coverage partial-coverage-2 issue-on-test-files mixed-languages 2-branches-4-conditions
do
	git checkout $branch
	branchOpt=""
	if [ "$branch" != "master" ]; then
		branchOpt="-Dsonar.branch.name=$branch"
	fi
	mvn clean org.jacoco:jacoco-maven-plugin:prepare-agent install org.jacoco:jacoco-maven-plugin:report \
		-Dmaven.test.failure.ignore=true \
		sonar:sonar $branchOpt \
		-Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN \
		-Dsonar.exclusions=pom.xml \
		-Dsonar.projectKey="training:coverage" -Dsonar.projectName="Training: Coverage" $*
done
# Return to the branch we started from
git checkout $startingBranch
