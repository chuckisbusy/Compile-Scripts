#!/bin/bash
#

cd $HOME/src
git clone https://github.com/rdk/p2rank.git
cd p2rank
./make.sh       
./unit-tests.sh      
./tests.sh quick