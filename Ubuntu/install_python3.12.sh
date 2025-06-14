#!/bin/sh
# Install Python 3.13.2:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/

apt-get install build-essential
apt-get install gcc openssl libssl-dev zlib1g zlib1g-dev
cd /opt
wget https://www.python.org/ftp/python/3.11.12/Python-3.11.12.tar.xz
tar xf Python-3.13.2.tar.xz
rm Python-3.13.2.tar.xz
cd Python-3.13.2
./configure --prefix=/opt/Python-3.13.2 --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath=/opt/Python-3.13.2/lib"
make
make altinstall

# Strip the Python 3.6 binary:
strip /opt/Python-3.13.2/lib/libpython3.13.so.1.0

#Add Python 3.6 to appropriate locations
ln -s /opt/Python-3.13.2/bin/python3.13 /usr/local/bin/python3.13
ln -s /opt/Python-3.13.2/bin/python3.13 /usr/bin/python3.13
ln -s /opt/Python-3.13.2/bin/pip3.13 /usr/local/bin/pip3.13
ln -s /opt/Python-3.13.2/bin/pip3.13 /usr/bin/pip3.13