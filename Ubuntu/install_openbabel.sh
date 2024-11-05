#!/bin/sh
#

sudo apt update
sudo apt install build-essential cmake git libcairo2-dev libeigen3-dev libffi-dev libfreetype6-dev libpng-dev libpython3-dev libxml2-dev qtbase5-dev zlib1g-dev libboost-all-dev libwxgtk3.0-gtk3-dev
cd /usr/local/src
git clone https://github.com/openbabel/openbabel.git
cd openbabel
git checkout tags/openbabel-3-1-1
mkdir build
cd build
cmake ..
make
make install
obabel -V