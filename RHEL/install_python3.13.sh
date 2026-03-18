#!/bin/sh
# Install Python 3.13.2:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/
CXX="/usr/bin/g++"

# Install openssl
cd /opt
wget https://www.openssl.org/source/openssl-1.1.1u.tar.gz
tar xvf openssl-1.1.1u.tar.gz
rm openssl-1.1.1u.tar.gz
cd openssl-1.1*/
./config --prefix=/usr/local/openssl --openssldir=/usr/local/openssl
make -j $(nproc)
sudo make install
sudo ldconfig
sudo tee /etc/profile.d/openssl.sh<<EOF
export PATH=/usr/local/openssl/bin:\$PATH
export LD_LIBRARY_PATH=/usr/local/openssl/lib:\$LD_LIBRARY_PATH
EOF
source /etc/profile.d/openssl.sh
reset

# Compile Python 
yum install zlib zlib-devel sqlite sqlite-devel ncurses ncurses-devel mpdecimal-devel readline-devel -y
cd /opt
wget https://www.python.org/ftp/python/3.13.2/Python-3.13.2.tar.xz
tar xf Python-3.13.2.tar.xz
rm Python-3.13.2.tar.xz
cd Python-3.13.2
./configure --prefix=/opt/Python-3.13.2 --enable-unicode=ucs4 --enable-shared LDFLAGS="${LDFLAGS} -Wl,-rpath=/opt/Python-3.13.2/lib" --with-openssl=/usr/local/openssl CXX="/usr/bin/g++"
make -j $(nproc)
make altinstall
sudo python3.13 -m pip install --upgrade pip

# Strip the Python 3.13 binary:
strip /opt/Python-3.13.2/lib/libpython3.13.so.1.0

# Add Python3.13 to appropriate locations
ln -s /opt/Python-3.13.2/bin/python3.13 /usr/local/bin/python3.13
ln -s /opt/Python-3.13.2/bin/python3.13 /usr/bin/python3.13

# Install & setup Pip; Force the installation of `setuptools` and `wheel` on newer Python versions
wget https://bootstrap.pypa.io/get-pip.py
python3.13 get-pip.py
python3.13 get-pip.py setuptools wheel

# Add Pip3.13 to appropriate locations
ln -s /opt/Python-3.13.2/bin/pip3.13 /usr/local/bin/pip3.13
ln -s /opt/Python-3.13.2/bin/pip3.13 /usr/bin/pip3.13
