#!/bin/bash
cd python
mkdir -p build && cd build
../configure --enable-optimizations --enable-shared
make && make install
# Make it so we can use this python in the container
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/src/src/thirdparty/python/build
rm /usr/bin/python3 /usr/bin/python
ln -s /usr/local/bin/python3.12 /usr/bin/python3
ln -s /usr/local/bin/python3.12 /usr/bin/python
# Export headers and compiled libs
cd ../..
mkdir -p libs/python/
cp python/build/libpython3.12.a python/build/libpython3.12.so.1.0 libs/python/
mkdir -p include/python/
cp -r python/Include/* include/python/
cp python/build/pyconfig.h include/python/
