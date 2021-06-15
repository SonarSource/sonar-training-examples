#!/bin/bash

# Load common environment
. ../sqlib.sh

DEF_FILE=portfolios-def.txt

me=$(basename $0)
if [ "$1" != "" ]; then
	echo "Usage: $me [-h]"
	exit 1
fi

nbportfolios=$(cat $DEF_FILE | wc -l)
i=$nbportfolios

while [ $i -ge 1 ]; do
   portfolio=`cat $DEF_FILE | head -n $i | tail -n 1`
	key=$(echo "$portfolio" | cut -d "," -f 1)
   echo "Deleting portfolio key $key"
	curl -X POST -u $SONAR_TOKEN: $SONAR_HOST_URL/api/views/delete?key=$key
   let i=$(expr $i-1)
done
