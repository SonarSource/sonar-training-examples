#!/bin/bash

# Load common environment
. ../sqlib.sh

DEF_FILE=portfolios-def.txt

me=$(basename $0)
if [ "$1" != "" ]; then
	echo "Usage: $me [-h|-?]"
	echo ""
	echo "Deletes the portfolios and the application described in $DEF_FILE."
	case "$1" in
	-h|-\?) exit 0 ;;
	*) exit 1 ;;
	esac
fi

# Reverse the definitions so parents are deleted before the portfolios they reference
reverse() {
	tail -r "$1" 2>/dev/null || tac "$1"
}

reverse $DEF_FILE | while IFS=, read -r key name mode params desc; do
	[ -z "$key" ] && continue
	echo "Deleting portfolio key $key"
	if [ "$mode" == "APPLICATION" ]; then
		curl -s -X POST -u $SONAR_TOKEN: --data-urlencode "application=$key" "$SONAR_HOST_URL/api/applications/delete"
	else
		curl -s -X POST -u $SONAR_TOKEN: --data-urlencode "key=$key" "$SONAR_HOST_URL/api/views/delete"
	fi
	echo ""
done
