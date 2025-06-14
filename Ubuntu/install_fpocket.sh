#!/bin/bash
#

sudo apt-get install libnetcdf-dev
cd $HOME/src
git clone https://github.com/Discngine/fpocket.git
cd fpocket
make 
make install