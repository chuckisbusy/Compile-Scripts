#!/bin/sh
# Install Python 3.11.10:
#
# Reference
# https://danieleriksson.net/2017/02/08/how-to-install-latest-python-on-centos/

sudo apt-get install libssl-dev zlib1g-dev libncurses-dev sqlite3 tk-dev libsqlite3-dev libc6-dev libgdbm-dev libffi-dev

# Compile Python
cd /opt
wget https://www.python.org/ftp/python/3.11.10/Python-3.11.10.tar.xz
tar xf Python-3.11.10.tar.xz
rm Python-3.11.10.tar.xz
cd Python-3.11.10
./configure --prefix=/opt/Python-3.11.10 --enable-unicode=ucs4 --enable-shared LDFLAGS="${LDFLAGS} -Wl,-rpath=/opt/Python-3.11.10/lib"
make -j $(nproc)
make altinstall

# Strip the Python 3.11 binary:
strip /opt/Python-3.11.10/lib/libpython3.11.so.1.0 

#Add Python 3.11 to appropriate locations
ln -s /opt/Python-3.11.10/bin/python3.11 /usr/local/bin/python311
ln -s /opt/Python-3.11.10/bin/python3.11 /usr/bin/python311
ln -s /opt/Python-3.11.10/bin/pip3.11 /usr/local/bin/pip311
ln -s /opt/Python-3.11.10/bin/pip3.11 /usr/bin/pip311
