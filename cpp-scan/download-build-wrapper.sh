#!/bin/bash
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

if [ "$SQ_URL" != "" ]; then
   sqUrl=$SQ_URL
else
   echo $SONAR_SCANNER_URL | grep 'sonar.host.url' 1>/dev/null
   if [ $? -eq 0 ]; then
   	sqUrl=$(echo $SONAR_SCANNER_OPTS | sed -e 's/.*sonar.host.url=//' -e 's/ .*//')
   else
      sqUrl=http://localhost:9000
   fi
fi

# Download and unzip latest build wrapper
echo "Downloading build wrapper:"
echo "- from $sqUrl/static/cpp/$OS_WRAPPER.zip"
echo "- to $WRAPPER_DOWNLOAD_LOC/wrapper.zip..."
curl -s --create-dirs -o $WRAPPER_DOWNLOAD_LOC/wrapper.zip $sqUrl/static/cpp/$OS_WRAPPER.zip
echo "Unzipping..."
cd $WRAPPER_DOWNLOAD_LOC; unzip -q -o wrapper.zip; cd - 1>/dev/null
echo "Build Wrapper downloaded at $WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER"
$WRAPPER_DOWNLOAD_LOC/$OS_WRAPPER/$OS_WRAPPER -v
