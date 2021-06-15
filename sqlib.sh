#!/bin/bash

# This file to be source'd by other shells makes sure that a common environment is used for all
# SonarQube API calls and scanner execution

if [ "$SONAR_TOKEN" = "" ]; then
   if [ "$TOKEN" != "" ]; then
      export SONAR_TOKEN=$TOKEN
   fi
fi
if [ "$SONAR_TOKEN" = "" ]; then
   printf "SonarQube token not set. Enter token: "
   read token
   export SONAR_TOKEN=$token
fi

if [ "$SONAR_HOST_URL" = "" ]; then
   if [ "$URL" != "" ]; then
      export SONAR_HOST_URL=$URL
   fi
fi
if [ "$SONAR_HOST_URL" = "" ]; then
   printf "SonarQube URL not set. Enter URL: "
   read url
   export SONAR_HOST_URL=$url
fi

# Strip possible past login and URL from SCANNER_OPTS
opts=`echo $SONAR_SCANNER_OPTS | sed -e 's/-Dsonar.host.url=[^ ]*//g' -e 's/-Dsonar.login=[^ ]*//g' -e 's/-Dsonar.password=\S*//g'`
# Set new login and URL
export SONAR_SCANNER_OPTS="$opts -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_TOKEN"

printf "\n\nRunning against $SONAR_HOST_URL\n\n"
