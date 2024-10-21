#!/bin/sh

#
#This script will run the AMBER 16 installation and the latest patches.
#It needs to be run as root.
#

export AMBERHOME=/usr/local/amber16
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export PATH="$CUDA_HOME/bin:$PATH"
#export MPI_HOME=/usr/local/mpich2-1.4.1p1
export MPI_HOME=/usr/local/mpich-3.1.4
export LD_LIBRARY_PATH="$MPI_HOME/lib:$LD_LIBRARY_PATH"
export PATH="$MPI_HOME/bin:$PATH"
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$AMBERHOME/lib64
test -f $AMBERHOME/amber.sh && source $AMBERHOME/amber.sh

echo "BEGIN ****************"
cd $AMBERHOME

./configure --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean
echo "FINISHED gnu ***************"

source /usr/local/amber16/amber.sh 

./configure -mpi --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
export DO_PARALLEL='mpirun -np 2'
make test
export DO_PARALLEL='mpirun -np 8'
make test
make clean
echo "FINISHED mpi ***************"

./configure -cuda --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
make clean
echo "FINISHED cuda *************"

./configure -mpi -cuda --with-python /opt/Python-2.7.14/bin/python2.7 gnu
make -j8 install
export DO_PARALLEL='mpirun -np 2'
make test
export DO_PARALLEL='mpirun -np 8'
make test
make clean
echo "FINISHED cuda mpi gnu ***************"

echo ""
echo "Update Complete"
