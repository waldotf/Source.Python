#!/bin/bash
cd python
mkdir -p build && cd build
../configure --enable-optimizations --enable-shared
make && make install
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/src/src/thirdparty/python/build
ln -s /usr/local/bin/python /usr/bin/python3
ln -s /usr/local/bin/python /usr/bin/python
