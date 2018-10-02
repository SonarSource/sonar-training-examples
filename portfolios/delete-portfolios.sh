#!/bin/bash

DEF_FILE=portfolios-def.txt

me=$(basename $0)
if [ "$1" != "" ]; then
	echo "Usage: $me [-h]"
	exit 1
fi

AUTH="-Dsonar.login=$TOKEN"

# Create the portfolio

nbportfolios=$(cat $DEF_FILE | wc -l)
i=$nbportfolios

while [ $i -ge 1 ]; do
   portfolio=`cat $DEF_FILE | head -n $i | tail -n 1`
	key=$(echo "$portfolio" | cut -d "," -f 1)
   echo "Deleting portfolio key $key"
	curl -X POST -u $TOKEN: $SQ_URL/api/views/delete?key=$key
   let i=$(expr $i-1)
done
