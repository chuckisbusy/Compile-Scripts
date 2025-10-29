#!/bin/sh
# Install Clustal Omega:
#
# Reference
# https://thelinuxcluster.com/tag/argtable2/

# Install argtable2
cp /home/elq764/Downloads/argtable2-13.tar.gz /home/elq764/src/
cd /home/elq764/src/
tar -zxvf argtable2-13.tar.gz
rm argtable2-13.tar.gz
cd argtable2-13
./configure --prefi=/home/elq764/src/argtable2-13
make
make install

# Install Clustal Omega
cp /home/elq764/Downloads/clustal-omega-1.2.4.tar.gz /home/elq764/src/
cd /home/elq764/src/
tar -zxvf clustal-omega-1.2.4.tar.gz
rm clustal-omega-1.2.4.tar.gz
cd clustal-omega-1.2.4
./configure --prefix=/home/elq764/src/clustal-omega-1.2.4 CFLAGS='-I/home/elq764/src/argtable2-13/include' LDFLAGS='-L/home/elq764/src/argtable2-13/lib'
make
make install

# Creating linking exe
cd /home/elq764/bin
ln -s /home/elq764/src/clustal-omega-1.2.4/bin/clustalo clustalo