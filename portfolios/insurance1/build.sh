#!/bin/bash


ls | grep '.xcodeproj' >/dev/null
foundXcode=$?
if [ "$*" != "" ]; then
   BUILD_CMD="$*"
elif [ -f makefile ]; then
	BUILD_CMD="make clean all"
elif [ $foundXcode ]; then
	BUILD_CMD="xcodebuild clean build"
else
	echo "Usage: $0 <build_command>"
fi

BW_DIR="bw-dir"

GEN_WRAPPER=$SQ_HOME/wrapper
if [ `uname` = "Darwin" ]; then
   OS_WRAPPER=build-wrapper-macosx-x86
else
   OS_WRAPPER=build-wrapper-linux-x86-64
fi
# Download and unzip latest build wrapper
curl -O -o $GEN_WRAPPER.zip $SQ_URL/static/cpp/$OS_WRAPPER.zip
unzip -o $GEN_WRAPPER.zip

$SQ_HOME/$OS_WRAPPER/$OS_WRAPPER --out-dir $BW_DIR $BUILD_CMD

sonar-scanner -Dsonar.cfamily.build-wrapper-output=$BW_DIR
