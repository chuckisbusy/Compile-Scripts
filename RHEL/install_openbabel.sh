#!/bin/bash
#
# PATH Settings-----------
# export PATH="/usr/local/src/openbabel-install/bin/:$PATH"
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"/usr/local/src/openbabel-install/lib"
#
#

sudo yum install wxGTK wxGTK3 cairo-devel eigen3-devel cmake3 -y
cp -rp openbabel-3.1.1-source.tar.bz2 /usr/local/src
cd /usr/local/src
tar -xvjf openbabel-3.1.1-source.tar.bz2   # (this creates openbabel-3.1.1)
rm -rf openbabel-3.1.1-source.tar.bz2
mkdir -vp openbabel-install
cd openbabel-install
cmake3 ../openbabel-3.1.1 -DCMAKE_INSTALL_PREFIX=/usr/local/src/openbabel-3.1.1
#cmake ../openbabel-3.1.1 -DCMAKE_INSTALL_PREFIX=/usr/local/src/openbabel-install -DCMAKE_BUILD_TYPE=DEBUG
make
make -j4
make install
echo INSTALL COMPLETE