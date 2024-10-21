#!/bin/sh
#

cd /usr/local/src
name="swig-3.0.12"
wget http://prdownloads.sourceforge.net/swig/${name}.tar.gz
tar -zxf ${name}.tar.gz
rm ${name}.tar.gz
cd $name
./autogen.sh
./configure --without-clisp --without-maximum-compile-warnings
make
make -k check TCL_INCLUDE= GOGCC=true
make install
echo Complete *****************
