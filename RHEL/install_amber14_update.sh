#!/bin/bash

#
#This script will update the Exxact AMBER 14 installation for the latest patches.
#It needs to be run as root.
#
export AMBERHOME=/usr/local/amber14
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export PATH="$CUDA_HOME/bin:$PATH"
#export MPI_HOME=/usr/local/mpich2-1.4.1p1
export MPI_HOME=/usr/local/mpich-3.1.4
export LD_LIBRARY_PATH="$MPI_HOME/lib:$LD_LIBRARY_PATH"
export PATH="$MPI_HOME/bin:$PATH"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$AMBERHOME/lib64
test -f $AMBERHOME/amber.sh && source $AMBERHOME/amber.sh

echo "Updating your Exxact Amber Certified Amber v14 installation for latest patches."
echo "It will take approximately 10 minutes to complete."

sleep 4

cd $AMBERHOME
make clean

./update_amber

./configure --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean
./configure -mpi --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean
./configure -cuda --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean
./configure -cuda -mpi --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean

echo ""
echo "Update Complete"
