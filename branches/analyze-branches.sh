#!/bin/bash

# Set SQ environment
. ../sqlib.sh

FILE="src/helloworld/HelloWorld.java"
PK="training:branches"
PN="Training: Branches"

if [ "$1" == "-h" ] || [ "$1" == "-?" ]; then
   echo "Usage: $0 [-h|-?]"
   echo ""
   echo "Analyzes the main branch plus a release, feature and hotfix branch of the"
   echo "same project so their issues and new code can be compared in SonarQube."
   echo "Requires Developer Edition or above."
   exit 0
fi

PARAMS="-Dsonar.host.url=$SONAR_HOST_URL -Dsonar.token=$SONAR_TOKEN -Dsonar.projectKey=$PK"

cp $FILE.orig $FILE

# Delete existing project
curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/projects/delete?project=$PK
echo ""

# Scan initial main branch
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.projectVersion=1.0

# Release branch
# Scan the baseline code from the branched main branch
sonar-scanner $PARAMS -Dsonar.branch.name=release-1.1

# Modify code, delete LoCs, inject 1 issue, add other LoCs
cat $FILE.orig | grep -v LINE-DELETE-RELEASE | sed -e 's/ISSUE-RELEASE/FIXME to fix for the release/' | sed -e 's/\/\/ LINE-ADD-RELEASE //g' > $FILE
# Scan after changes
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.branch.name=release-1.1
# Backup file
cp $FILE $FILE.release.$$

# Change main branch and scan with incremented version
# Modify code, inject 1 issue, add LoCs
cat $FILE.orig | grep -v LINE-DELETE-MASTER | sed -e 's/ISSUE-MASTER/FIXME to fix on master/' | sed -e 's/\/\/ LINE-ADD-MASTER //g' > $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.projectVersion=2.0
cp $FILE $FILE.master.$$

# Create feature branch on the main branch
# Modify code, inject 1 issue, add LoCs
cat $FILE.master.$$ | grep -v LINE-DELETE-FEATURE | sed -e 's/ISSUE-FEATURE/FIXME to fix on feature branch/' | sed -e 's/\/\/ LINE-ADD-FEATURE //g' > $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.branch.name=feature-X
cp $FILE $FILE.feature.$$

# Create hotfix branch on release branch
# Fix release issues
cat $FILE.release.$$ | grep -v FIXME > $FILE
# Inject one new issue
echo "// FIXME issue introduced in hotfix" >> $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.branch.name=hotfix-for-release

rm -f $FILE.*.$$

# Leave the working tree in its pristine state
cp $FILE.orig $FILE
