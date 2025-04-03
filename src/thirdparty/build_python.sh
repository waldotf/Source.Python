#!/bin/bash
cd python
mkdir -p build && cd build
../configure --enable-optimizations --enable-shared
make && make install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/src/src/thirdparty/python/build
rm /usr/bin/python3 /usr/bin/python
ln -s /usr/local/bin/python3.12 /usr/bin/python3
ln -s /usr/local/bin/python3.12 /usr/bin/python
