#!/bin/bash

# Load common environment
. ../sqlib.sh

DEF_FILE=portfolios-def.txt

me=$(basename $0)
if [ "$1" != "" ]; then
	echo "Usage: $me [-h|-?]"
	echo ""
	echo "Creates the portfolios and the application described in $DEF_FILE."
	echo "Portfolios and applications require Enterprise Edition or above."
	case "$1" in
	-h|-\?) exit 0 ;;
	*) exit 1 ;;
	esac
fi

# POST to a web service, URL-encoding every parameter given as key=value
sqpost() {
	local path=$1
	shift
	local args=()
	for param in "$@"; do
		args+=(--data-urlencode "$param")
	done
	curl -s -X POST -u $SONAR_TOKEN: "${args[@]}" "$SONAR_HOST_URL/$path" 1>/dev/null
}

while IFS=, read -r key name mode params desc; do
	[ -z "$key" ] && continue
	echo "Creating portfolio key $key, name $name, mode $mode, params $params"

	case $mode in
	APPLICATION)
		sqpost api/applications/create "key=$key" "name=$name" "description=$desc"
		for projkey in $params; do
			echo "Adding project key $projkey to application"
			sqpost api/applications/add_project "application=$key" "project=$projkey"
		done
		;;
	REGEXP)
		sqpost api/views/create "key=$key" "name=$name" "description=$desc"
		sqpost api/views/set_regexp_mode "portfolio=$key" "regexp=$params"
		;;
	MANUAL)
		sqpost api/views/create "key=$key" "name=$name" "description=$desc"
		sqpost api/views/set_manual_mode "portfolio=$key"
		for projkey in $params; do
			echo "Adding project key $projkey to portfolio"
			sqpost api/views/add_project "key=$key" "project=$projkey"
		done
		;;
	PARENT)
		sqpost api/views/create "key=$key" "name=$name" "description=$desc"
		for subportkey in $params; do
			echo "Adding sub-portfolio key $subportkey to portfolio"
			sqpost api/views/add_portfolio "portfolio=$key" "reference=$subportkey"
		done
		;;
	*)
		echo "Unknown mode $mode, skipped"
		;;
	esac
done <$DEF_FILE
