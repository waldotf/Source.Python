mkdir -p boost && cd boost
wget https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
tar -zxvf boost_1_87_0.tar.gz && cd boost_1_87_0
./bootstrap.sh --prefix=/opt/boost #--with-python=/usr/local/bin/python3.12 --with-python-version=3.12.9+ --with-python-root=/usr/local/lib/python3.12
./b2  --build-dir=output python filesystem headers
# Export libs
cd ../../
mkdir -p libs/boost/
# Pack this into an archive
ar -cr libs/boost/libboost_python.a boost/boost_1_87_0/output/boost/bin.v2/libs/python/build/gcc-12/debug/x86_32/python-3.12/threading-multi/visibility-hidden/**/*.o
mkdir -p include/boost/
cp -r boost/boost_1_87_0/boost include/boost/
