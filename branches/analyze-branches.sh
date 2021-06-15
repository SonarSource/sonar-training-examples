#!/bin/bash

# Set SQ environment
. ../sqlib.sh

FILE="src/helloworld/HelloWorld.java"
PK="training:branches"
PN="Training: Branches"
BRANCH_PROP="sonar.branch.name"
TARGET_PROP="sonar.branch.target"

if [ "$1" == "-h" ]; then
   echo "$0 [sonar.branch] [-h]"
   echo "The default branch property is sonar.branch.name, but you can also pass sonar.branch"
   echo "to show the effect in SonarQube"
   echo "When using sonar.branch.name, the projetc key is training:branches"
   echo "When using sonar.branch, the projetc key is training:branches-old-style"
fi
if [ "$1" == "sonar.branch" ]; then
   PK="$PK-old-style"
   PN="$PN (old-style)"
   BRANCH_PROP="sonar.branch"
   TARGET_PROP="sonar.foo"
fi

PARAMS="-Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN -Dsonar.projectKey=$PK"

cp $FILE.orig $FILE

# Delete existing project
curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/projects/delete?project=$PK
echo ""

# Scan initial master branch
echo "sonar-scanner $PARAMS -Dsonar.projectName=\"$PN\" -Dsonar.projectVersion=1.0 -Dsonar.projectDate=2018-06-01"
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.projectVersion=1.0 -Dsonar.projectDate=2018-06-01 -X

# Release branch
# Scan the baseline code from the branched master
sonar-scanner $PARAMS -D$BRANCH_PROP=release-1.1

# Modify code, delete LoCs, inject 1 issue, add other LoCs
cat $FILE.orig | grep -v LINE-DELETE-RELEASE | sed -e 's/ISSUE-RELEASE/FIXME to fix for the release/' | sed -e 's/\/\/ LINE-ADD-RELEASE //g' > $FILE
# Scan after changes
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -D$BRANCH_PROP=release-1.1
# Backup file
cp $FILE $FILE.release.$$

# Change master branch and scan with incremented version
# Modify code, inject 1 issue, add LoCs
cat $FILE.orig | grep -v LINE-DELETE-MASTER | sed -e 's/ISSUE-MASTER/FIXME to fix on master/' | sed -e 's/\/\/ LINE-ADD-MASTER //g' > $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -Dsonar.projectVersion=2.0
cp $FILE $FILE.master.$$

# Create feature branch on master
# Modify code, inject 1 issue, add LoCs
cat $FILE.master.$$ | grep -v LINE-DELETE-FEATURE | sed -e 's/ISSUE-FEATURE/FIXME to fix on feature branch/' | sed -e 's/\/\/ LINE-ADD-FEATURE //g' > $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -D$BRANCH_PROP=feature-X
cp $FILE $FILE.feature.$$

# Create feature branch on release branch
# Fix release issues
cat $FILE.release.$$ | grep -v FIXME > $FILE
# Inject one new issue
echo "// FIXME issue introduced in hotfix" >> $FILE
sonar-scanner $PARAMS -Dsonar.projectName="$PN" -D$BRANCH_PROP=hotfix-for-release -D$TARGET_PROP=release-1.1

rm -f $FILE.*.$$
