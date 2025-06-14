#!/bin/bash
#
cd ~/src
wget https://archives.boost.io/release/1.88.0/source/boost_1_88_0.tar.bz2
tar --bzip2 -xf boost_1_88_0.tar.bz2
cd boost_1_88_0
./bootstrap.sh --prefix=$HOME/src/boost_1_88_0
./b2 install

echo "Set your environment:"
echo "export BOOST_ROOT="$HOME/boost_1_84_0""
echo "export INCLUDE="$HOME/boost_1_84_0:$INCLUDE""
echo "export LD_LIBRARY_PATH="$HOME/boost_1_84_0/lib:$LD_LIBRARY_PATH""