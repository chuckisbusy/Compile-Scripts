#!/bin/sh
#

cd /usr/local/src
git clone https://github.com/htop-dev/htop
cd htop
./autogen.sh
./configure
make
make install
rm /usr/bin/htop
ln -s /usr/local/${name}/htop /usr/bin/htop
