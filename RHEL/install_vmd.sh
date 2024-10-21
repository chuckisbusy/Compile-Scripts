#!/bin/sh
#

cp /net/share/cad234/source/vmd-1.9.3.bin.LINUXAMD64.opengl.tar /usr/local/src
cd /usr/local/src
tar xvf vmd-1.9.3.bin.LINUXAMD64.opengl.tar
rm vmd-1.9.3.bin.LINUXAMD64.opengl.tar
cd vmd-1.9.3
./configure LINUXAMD64
cd src
make install
