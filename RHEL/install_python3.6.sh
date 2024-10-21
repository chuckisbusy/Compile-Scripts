#!/bin/sh
# Install Python 3.6.5:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/

yum install openssl openssl-devel zlib zlib-devel -y
cd /opt
wget https://www.python.org/ftp/python/3.6.5/Python-3.6.5.tar.xz
tar xf Python-3.6.5.tar.xz
rm Python-3.6.5.tar.xz
cd Python-3.6.5
./configure --prefix=/opt/Python-3.6.5 --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath=/opt/Python-3.6.5/lib"
make && make altinstall

# Strip the Python 3.6 binary:
strip /opt/Python-3.6.5/lib/libpython3.6m.so.1.0

# Get the pip script:
wget https://bootstrap.pypa.io/get-pip.py
 
#Execute it using Python 3.6
/opt/Python-3.6.5/bin/python3.6 get-pip.py

#Add Python 3.6 to appropriate locations
ln -s /opt/Python-3.6.5/bin/python3.6 /usr/local/bin/python36
ln -s /opt/Python-3.6.5/bin/python3.6 /usr/bin/python36
ln -s /opt/Python-3.6.5/bin/pip3.6 /usr/local/bin/pip36
ln -s /opt/Python-3.6.5/bin/pip3.6 /usr/bin/pip36
ln -s /opt/Python-3.6.5/bin/pip3.6 /usr/bin/pip3
