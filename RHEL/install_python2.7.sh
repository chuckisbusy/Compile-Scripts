#!/bin/sh
# Install Python 2.7.14:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/

yum install openssl openssl-devel zlib zlib-devel -y
cd /opt
wget http://python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz
tar xf Python-2.7.14.tar.xz
rm Python-2.7.14.tar.xz
cd Python-2.7.14
./configure --prefix=/opt/Python-2.7.14 --enable-unicode=ucs4 --enable-shared LDFLAGS="-Wl,-rpath=/opt/Python-2.7.14/lib"
make && make altinstall

# Strip the Python 2.7 binary:
strip /opt/Python-2.7.14/lib/libpython2.7.so.1.0

# Get the pip script:
wget https://bootstrap.pypa.io/get-pip.py
 
#Execute it using Python 2.7
/opt/Python-2.7.14/bin/python2.7 get-pip.py

#Add Python 2.7 to appropriate locations
ln -s /opt/Python-2.7.14/bin/python2.7 /usr/local/bin/python27
ln -s /opt/Python-2.7.14/bin/python2.7 /usr/bin/python27
ln -s /opt/Python-2.7.14/bin/pip2.7 /usr/bin/pip27
