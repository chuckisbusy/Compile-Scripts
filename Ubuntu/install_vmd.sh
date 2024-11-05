#!/bin/sh
#

cp /home/$USER/Downloads/vmd-1.9.4a57.bin.LINUXAMD64-CUDA102-OptiX650-OSPRay185.opengl.tar.gz /usr/local/src
cd /usr/local/src
tar xzvf vmd-1.9.4a57.bin.LINUXAMD64-CUDA102-OptiX650-OSPRay185.opengl.tar.gz
rm vmd-1.9.4a57.bin.LINUXAMD64-CUDA102-OptiX650-OSPRay185.opengl.tar.gz
cd vmd-1.9.4a57
./configure LINUXAMD64
cd src
make install
