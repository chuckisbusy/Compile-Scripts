#!/bin/bash
#

cd /usr/local/src
mkdir -vp autodocksuite && $_
sudo tar xvzf ~/Software/autodocksuite-4.2.6-src.tar.gz -C .
cd src/autodock
mkdir -vp x86_64Linux2 && cd $_
sudo ../configure
sudo make
sudo make check  #(optional but recommended, requires "python")
sudo make install #(optional, this will install autodock4 executable)


cd ../../autogrid
mkdir -vp x86_64Linux2 && cd $_
sudo ../configure
sudo make
sudo make check 
sudo make install