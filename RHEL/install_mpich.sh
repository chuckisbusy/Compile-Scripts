#!/bin/sh
#

cd /usr/local/src
tar xvzf mpich2-1.4.1p1.tar.gz
cd mpich2-1.4.1p1
./configure
make
make install
echo Done
