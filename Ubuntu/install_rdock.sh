#!/bin/bash
#

cd $HOME/src
git clone https://github.com/CBDD/rDock
cd rDock
make -j4
make test

echo "Set rDock environment"
echo "export RBT_ROOT=$HOME/src/rDock"
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$RBT_ROOT/lib"
echo "export PATH=$PATH:$RBT_ROOT/bin"