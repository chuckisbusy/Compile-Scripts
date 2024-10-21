#!/bin/bash
#

cd /usr/local/src
wget http://www.povray.org/redirect/www.povray.org/ftp/pub/povray/Old-Versions/Official-3.62/Linux/povlinux-3.6.tgz
tar xvfz povlinux-3.6.tgz
rm -rf povlinux-3.6tgz
cd povray-3.6
./install -no-arch-check