#!/bin/bash
#

mkdir -vp eigen3
wget http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2
tar xf 3.3.7.tar.bz2
mv eigen-eigen-323c052e1731 eigen3/
rm -rf 3.3.7.tar.bz2
mkdir -vp eigen3-build
cd eigen3-build
cmake ../eigen3 -DCMAKE_INSTALL_PREFIX=../eigen3
make install

export PATH="$PATH:/home/cad234/share/eigen3/include/eigen3/"

cp /home/cad234/Software/openbabel-2.4.1.tar /usr/local/src
cd /usr/local/src
tar -xf openbabel-2.4.1.tar
rm openbabel-2.4.1.tar
mkdir -vp openbabel-install && cd $_
cmake ../openbabel-2.4.1 -DCMAKE_INSTALL_PREFIX=../openbabel-2.4.1/
make -j4
make install
