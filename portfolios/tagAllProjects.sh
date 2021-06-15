#!/bin/bash

# Load common environment
. ../sqlib.sh

tag="superbank.com"

KEYS="BANK-RETAIL-401K WEBSITE-TIER2-BIZLOGIC"

echo "--------------------------------------------------------"
echo " Tagging all company projects with tag $tag"
echo "--------------------------------------------------------"
for p in `ls | grep -e tier -e bank -e insurance`; do
	if [ -f "$p/sonar-project.properties" ]; then
      # We extract the key from sonar-project.properties
		pk=`grep sonar.projectKey $p/sonar-project.properties | cut -d '=' -f 2`
	   echo curl -X POST -u '$SONAR_TOKEN:' "$SONAR_HOST_URL/api/project_tags/set?project=$pk&tags=$tag"
	   curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$pk&tags=$tag"
   fi
done
for pk in $KEYS; do
	echo curl -X POST -u '$SONAR_TOKEN:' "$SONAR_HOST_URL/api/project_tags/set?project=$pk&tags=$tag"
	curl -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/project_tags/set?project=$pk&tags=$tag"
done
