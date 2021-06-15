#!/bin/bash

me=$(basename $0)

# Load common environment
. ../sqlib.sh

KEYS="bank9=BANK-RETAIL-401K
tier2-biz-logic=WEBSITE-TIER2-BIZLOGIC"

echo "--------------------------------------------------------"
echo " Scanning all company projects"
echo "--------------------------------------------------------"
for p in `ls | grep -e tier -e bank -e insurance | grep -v $me`; do
   echo "Scanning $p..."
	cd $p; ./build.sh 1>>build.log 2>&1; cd ..;
	if [ -f "$p/sonar-project.properties" ]; then
      # We extract the key from sonar-project.properties
		pk=`grep sonar.projectKey $p/sonar-project.properties | cut -d '=' -f 2`
   else
      # We extract the key from the static mapping table
		pk=`echo $KEYS | grep $p | cut -d '=' -f 2`
	fi
	curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$pk&tags=superbank.com"
done
