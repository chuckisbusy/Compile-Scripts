#!/bin/sh
#

cd /usr/local/src
svn checkout svn://svn.mplayerhq.hu/mplayer/trunk mplayer
cd mplayer
make clean
./configure
make
make install
ldconfig