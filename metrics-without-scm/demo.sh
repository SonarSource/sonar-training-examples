#!/bin/bash

file1=src/custmgt.cbl
file2=$file1.2.cbl


if [ "$1" = "add-code" ]; then
   # Create a new file and uncomment a line
   cat $file1 | sed 's/\*NEWCODE //' >$file2
elif [ "$1" = "reset" ]; then
   rm -f $file2
else
	echo "Usage: $0 [reset|add-code]"
fi

