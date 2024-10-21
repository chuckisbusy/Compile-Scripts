#!/bin/bash
#

yum groupinstall 'Development Tools' -y
yum install gcc-gfortran -y
name="openmpi-4.0.1"
file=$name.tar.gz

cd /usr/local/src
wget https://download.open-mpi.org/release/open-mpi/v4.0/$file
tar xvzf $file
rm $file
cd $name
./configure --prefix=/usr/local
make all install
echo Installation Complete
