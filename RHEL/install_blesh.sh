#!/bin/bash
#

dir="/home/$USER/Github"

if [ ! -d $dir ]
then
     mkdir $dir && cd $_
else
     cd $dir
fi

git clone --recursive https://github.com/akinomyoga/ble.sh.git
cd ble.sh
make
make INSDIR="$HOME/.local/share/blesh" install