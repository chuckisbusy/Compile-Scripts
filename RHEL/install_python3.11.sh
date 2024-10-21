#!/bin/sh
# Install Python 3.11.4:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/

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
yum install zlib zlib-devel -y
cd /opt
wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tar.xz
tar xf Python-3.11.4.tar.xz
rm Python-3.11.4.tar.xz
cd Python-3.11.4
./configure --prefix=/opt/Python-3.11.4 --enable-unicode=ucs4 --enable-shared LDFLAGS="${LDFLAGS} -Wl,-rpath=/opt/Python-3.11.4/lib" --with-openssl=/usr/local/openssl 
make -j $(nproc)
make altinstall
sudo python311 -m pip install --upgrade pip

# Strip the Python 3.11 binary:
strip /opt/Python-3.11.4/lib/libpython3.11.so.1.0

#Add Python 3.11 to appropriate locations
ln -s /opt/Python-3.11.4/bin/python3.11 /usr/local/bin/python311
ln -s /opt/Python-3.11.4/bin/python3.11 /usr/bin/python311
ln -s /opt/Python-3.11.4/bin/pip3.11 /usr/local/bin/pip311
ln -s /opt/Python-3.11.4/bin/pip3.11 /usr/bin/pip311
