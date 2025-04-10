#!/bin/bash
cd DynamicHooks
chmod +x build-unix-x86-rel.sh
./build-unix-x86-rel.sh
cd ../build/Release
make all
