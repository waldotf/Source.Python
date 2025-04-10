#!/bin/bash
cd DynamicHooks
chmod +x build-unix-x86-rel.sh
./build-unix-x86-rel.sh
cd ..
# Extract libs
mkdir -p libs/dynamichooks/
mkdir -p include/dynamichooks/
cp DynamicHooks/Build/unix-x86/libDynamicHooks.a libs/dynamichooks/
# Extract includes
cp -r DynamicHooks/src/* include/dynamichooks/
# Remove duplicate AsmJit includes
rm -rf include/dynamichooks/thirdparty
# Prune cpp files
find include/dynamichooks/ -name *.cpp | xargs rm
find include/dynamichooks/ -name *.txt | xargs rm
