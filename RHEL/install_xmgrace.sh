#!/bin/sh
#

yum install openmotif openmotif-devel libXpm-devel libXp-devel xorg-x11-xbitmaps -y

cp ~/Downloads/grace-5.1.25.tar /usr/local/src
cd /usr/local/src
tar xvf grace-5.1.25.tar
cd grace-5.1.25
./configure 
make 
make install 
make links