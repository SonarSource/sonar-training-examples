#!/bin/bash

# Load common environment
. ../sqlib.sh

if [ "$1" == "-h" ]; then
	echo "Usage: $0 [-h] [<download-directory>]"
	echo "Default download directory is ./wrapper"
	exit 0
fi
WRAPPER_DOWNLOAD_LOC=${1:-wrapper}
if [ `uname` = "Darwin" ]; then
  OS_WRAPPER=build-wrapper-macosx-x86
else
  OS_WRAPPER=build-wrapper-linux-x86-64
fi

# Download and unzip latest build wrapper
echo "Downloading build wrapper:"
echo "- from $SQ_URL/static/cpp/$OS_WRAPPER.zip"
echo "- to $WRAPPER_DOWNLOAD_LOC/wrapper.zip..."
curl -s --create-dirs -o $WRAPPER_DOWNLOAD_LOC/wrapper.zip $SQ_URL/static/cpp/$OS_WRAPPER.zip
echo "Unzipping..."
cd $WRAPPER_DOWNLOAD_LOC; unzip -q -o wrapper.zip; cd - 1>/dev/null
echo "Build Wrapper downloaded at $WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER"

if [ ! -x "$WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER" ]; then
	echo "$WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER not found or not executable"
	exit 1
fi
$WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER || true
