#!/bin/bash
cd DynamicHooks
# Set DASMJIT_STATIC for cmake
sed -i 's/^-DASMJIT_TEST=1"$/-DASMJIT_TEST=1 -DASMJIT_STATIC=1/' build-unix-x86-rel.sh
chmod +x build-unix-x86-rel.sh
./build-unix-x86-rel.sh
cd ../build/Release
make all
