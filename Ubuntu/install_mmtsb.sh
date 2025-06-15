#!/bin/bash
#

cd $HOME/src/
git clone https://github.com/mmtsb/toolset.git
cd toolset/src
make all


echo "Set your environment"
echo "export MMTSBDIR=$HOME/src/toolset"
echo "export PATH=$PATH:$MMTSBDIR/perl:$MMTSBDIR/bin"
