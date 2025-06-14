#!/bin/bash
#

sudo yum install netcdf-devel.x86_64
cd $HOME/src
git clone https://github.com/Discngine/fpocket.git
cd fpocket
make 
make install
