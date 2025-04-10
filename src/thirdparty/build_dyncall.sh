#!/bin/bash
cd dyncall
# Set DASMJIT_STATIC for cmake
mkdir -p build && cd build
../configure
make
cd ../..
# Extract libs
mkdir -p libs/dyncall/
mkdir -p include/dyncall/
cp dyncall/build/dyncall/libdyncall_s.a libs/dyncall/
cp dyncall/build/dyncallback/libdyncallback_s.a libs/dyncall/
cp dyncall/build/dynload/libdynload_s.a libs/dyncall/
# Extract includes
cp -r dyncall/dyncall/*.h include/dyncall/
cp -r dyncall/dyncallback/*.h include/dyncall/
cp -r dyncall/dynload/*.h include/dyncall/
