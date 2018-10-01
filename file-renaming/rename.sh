#!/bin/bash

if [ "$1" == "-h" ]; then
   echo "Usage: $0 [-h]"
   echo "This will rename the class HelloWorld into HelloPlanet (and vice versa)"
   exit 0
fi
if [ -d src/helloworld ]; then
   oldclass=HelloWorld
   newclass=HelloPlanet
else
   oldclass=HelloPlanet
   newclass=HelloWorld
fi

echo "Renaming $oldclass.java into $newclass.java"

# Lowercase class names to build dir and apckage names
oldpack=`echo $oldclass | tr A-Z a-z`
newpack=`echo $newclass | tr A-Z a-z`

# Rename directory
cd src; mv $oldpack $newpack; cd - 1>/dev/null

# Replace package and class names in source file
oldfile=src/$newpack/$oldclass.java
newfile=src/$newpack/$newclass.java
cat $oldfile | sed -e "s/$oldclass/$newclass/g" -e "s/$oldpack/$newpack/g" >$newfile
rm $oldfile
