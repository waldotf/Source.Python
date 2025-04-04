#!/bin/bash
cd AsmJit
mkdir -p build
cd tools
# Set DASMJIT_STATIC for cmake
sed -i 's/^-DASMJIT_TEST=1"$/-DASMJIT_TEST=1 -DASMJIT_STATIC=1/' configure-makefiles.sh
./configure-makefiles.sh
cd ../build/Release
make all
# Export libs
cd ../../..
mkdir -p libs/AsmJit/
cp AsmJit/build/Release/libasmjit.so libs/AsmJit/
mkdir -p include/AsmJit/
cp -r AsmJit/src/* include/AsmJit/
# Prune cpp files
find include/AsmJit/ -name *.cpp | xargs rm

# Also copy to DynamicHooks submodule since we build that next
rm -rf DynamicHooks/src/thirdparty/AsmJit/include/*
cp libs/AsmJit/libasmjit.so DynamicHooks/src/thirdparty/AsmJit/lib/
cp -r include/AsmJit DynamicHooks/src/thirdparty/AsmJit/include/
