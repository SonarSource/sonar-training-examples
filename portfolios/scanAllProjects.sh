#!/bin/bash

me=$(basename $0)

echo "--------------------------------------------------------"
echo " Scanning all company projects"
echo "--------------------------------------------------------"
for p in `ls | grep -e corp -e tier -e bank -e insurance | grep -v $me`; do
   echo "Scanning $p..."
	cd $p; ./build.sh 1>/dev/null; cd ..;
done
