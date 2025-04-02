mkdir -p boost_all && cd boost_all
wget https://archives.boost.io/release/1.87.0/source/boost_1_87_0.tar.gz
tar -zxvf boost_1_87_0.tar.gz && cd boost_1_87_0
./bootstrap.sh --prefix=/opt/boost #--with-python=/usr/local/bin/python3.12 --with-python-version=3.12.9+ --with-python-root=/usr/local/lib/python3.12
./b2
#./b2 headers
#./b2 --prefix=/opt/boost --with-python install
