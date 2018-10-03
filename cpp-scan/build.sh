#!/bin/bash

rm -rf build
mkdir build

# Build directly each file
g++ -Wall -o build/BiggestUnInt src/BiggestUnInt.cc
g++ -Wall -o build/HelloWorld src/HelloWorld.cc
g++ -Wall -o build/SimpleClass src/SimpleClass.cc
