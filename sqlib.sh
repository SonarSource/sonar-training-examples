#!/bin/bash

# This file to be source'd by other shells makes sure that a common environment is used for all
# SonarQube API calls and scanner execution

if [ "$SQ_TOKEN" = "" ]; then
   if [ "$TOKEN" != "" ]; then
      export SQ_TOKEN=$TOKEN
   fi
fi
if [ "$SQ_TOKEN" = "" ]; then
   printf "SonarQube token not set. Enter token: "
   read token
   export SQ_TOKEN=$token
fi

if [ "$SQ_URL" = "" ]; then
   if [ "$URL" != "" ]; then
      export SQ_URL=$URL
   fi
fi
if [ "$SQ_URL" = "" ]; then
   printf "SonarQube URL not set. Enter URL: "
   read url
   export SQ_URL=$url
fi

# Strip possible past login and URL from SCANNER_OPTS
opts=`echo $SONAR_SCANNER_OPTS | sed -e 's/-Dsonar.host.url=[^ ]*//g' -e 's/-Dsonar.login=[^ ]*//g' -e 's/-Dsonar.password=\S*//g'`
# Set new login and URL
export SONAR_SCANNER_OPTS="$opts -Dsonar.host.url=$SQ_URL -Dsonar.login=$SQ_TOKEN"

printf "\n\nRunning against $SQ_URL\n\n"
