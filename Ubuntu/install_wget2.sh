#!/bin/sh
# Install wget2
#

ver='2.2.1'
wget https://ftp.gnu.org/gnu/wget/wget2-latest.tar.gz
tar xvzf wget-$ver.tar.gz
cd wget-$ver
./configure --prefix=/usr --with-ssl
make
make install
