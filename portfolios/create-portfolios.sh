#!/bin/bash

# Load common environment
. ../sqlib.sh

DEF_FILE=portfolios-def.txt

me=$(basename $0)
if [ "$1" != "" ]; then
	echo "Usage: $me [-h]"
	exit 1
fi

let finished=0
let i=1
nbportfolios=$(cat $DEF_FILE | wc -l)

while [ $i -le $nbportfolios ]; do
   portfolio=`cat $DEF_FILE | head -n $i | tail -n 1`
	key=$(echo "$portfolio" | cut -d "," -f 1)
	name=$(echo "$portfolio" | cut -d "," -f 2 | sed 's/ /%20/g')
	mode=$(echo "$portfolio" | cut -d "," -f 3 | sed 's/ /%20/g')
	params=$(echo "$portfolio" | cut -d "," -f 4)
	desc=$(echo "$portfolio" | cut -d "," -f 5 | sed 's/ /%20/g')
   echo "Creating portfolio key $key, name $name, mode $mode, params $params"
   if [ "$mode" == "APPLICATION" ]; then
      qualifier="&qualifier=APP"
   fi
	curl -s -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/views/create?name=$name&key=$key&description=$desc$qualifier" 1>/dev/null
   case $mode in
	REGEXP)
		regexp=$(echo $params | sed 's/ /%20/g')
		curl -s -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/views/mode?key=$key&selectionMode=$mode&regexp=$regexp" 1>/dev/null
      ;;
   MANUAL|APPLICATION)
      for projkey in $params; do
         echo "Adding project key $projkey to portfolio/application"
   		curl -s -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/views/add_project?key=$key&project_key=$projkey" 1>/dev/null
  	   done
      ;;
   PARENT)
      for subportkey in $params; do
         echo "Adding sub-portfolio key $subportkey to portfolio"
   		curl -s -X POST -u $SONAR_TOKEN: "$SONAR_HOST_URL/api/views/add_local_view?key=$key&ref_key=$subportkey" 1>/dev/null
  	   done
      ;;
   *)
      echo "Unknown mode $mode, skipped"
      ;;
   esac
   let i=$(expr $i+1)
done
