#!/bin/sh
#

yum install openssl openssl-devel zlib zlib-devel debugmode python34 python34-devel perl perl-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker perl-ExtUtils-Embed libicu libicu-devel cyrus-sasl cyrus-sasl-devel tcl tcl-devel -y
name="znc-1.7.0"
cd /usr/local/src
wget https://znc.in/releases/$name.tar.gz
tar -xvzf $name.tar.gz
rm $name.tar.gz
cd $name
./configure --enable-debug --enable-perl --enable-python --enable-cyrus --enable-tcl
make
make install
echo Complete!
