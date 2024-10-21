#!/bin/bash

#
#This script will run the AMBER 18 installation and the latest patches.
#It needs to be run as root.
#

export AMBERHOME=/usr/local/src/amber18
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$AMBERHOME/lib64
export PATH=$PATH:$AMBERHOME/bin
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH="$CUDA_HOME/lib:$CUDA_HOME/lib64:$LD_LIBRARY_PATH"
export PATH="$CUDA_HOME/bin:$PATH"
export MPI_HOME=/usr/local
export LD_LIBRARY_PATH="$MPI_HOME/lib:$LD_LIBRARY_PATH"
export PATH="$MPI_HOME/bin:$PATH"

tar=0
serial=0
serial_py=0
parallel_py_mpi=0
serial_py_cuda=1
parallel_py_cuda=1

yum -y install tcsh make gcc gcc-gfortran gcc-c++ which flex bison patch bc libXt-devel libXext-devel perl util-linux wget bzip2 bzip2-devel zlib-devel

echo "BEGIN ****************"
if [ $tar -eq 1 ]; then
	cp /home/chuck/Downloads/Amber18.tar.bz2 /usr/local/src
	cp /home/chuck/Downloads/AmberTools18.tar.bz2 /usr/local/src
	cd /usr/local/src/
	tar xjf AmberTools18.tar.bz2
	tar xjf Amber18.tar.bz2
	rm Amber*.bz2
	echo "FINISHED copying files**************"
fi

if [ $serial -eq 1 ]; then
	cd $AMBERHOME
	test -f /usr/local/src/amber18/amber.sh  && source /usr/local/src/amber18/amber.sh
	./configure gnu
	make install
	make test
	echo "FINISHED gnu ***************"
fi

if [ $serial_py -eq 1 ]; then
	cd $AMBERHOME
	test -f /usr/local/src/amber18/amber.sh  && source /usr/local/src/amber18/amber.sh
	./configure --with-python /opt/Python-2.7.18/bin/python2.7 gnu
	make install
	make test
	echo "FINISHED gnu w/ python ***************"
fi

if [ $parallel_py_mpi -eq 1 ]; then
	cd $AMBERHOME
	test -f /usr/local/src/amber18/amber.sh  && source /usr/local/src/amber18/amber.sh
	./configure -mpi --with-python /opt/Python-2.7.18/bin/python2.7 gnu
	make install
	export DO_PARALLEL='mpirun -np 2'
	make test
	export DO_PARALLEL='mpirun -np 4'
	make test
	export DO_PARALLEL='mpirun -np 8'
	make test
	make clean
	echo "FINISHED mpi ***************"
fi

if [ $serial_py_cuda -eq 1 ]; then
	cd $AMBERHOME
	test -f /usr/local/src/amber18/amber.sh  && source /usr/local/src/amber18/amber.sh
	./configure -cuda --with-python /opt/Python-2.7.18/bin/python2.7 gnu
	make install
	make test
	echo "FINISHED cuda *************"
fi

if [ $parallel_py_cuda -eq 1 ]; then
	cd $AMBERHOME
	test -f /usr/local/src/amber18/amber.sh  && source /usr/local/src/amber18/amber.sh
	./configure -mpi -cuda --with-python /opt/Python-2.7.18/bin/python2.7 gnu
	make install
	export DO_PARALLEL='mpirun -np 2'
	make test
	export DO_PARALLEL='mpirun -np 4'
	make test
	export DO_PARALLEL='mpirun -np 8'
	make test
	make clean
	echo "FINISHED cuda mpi gnu ***************"
fi

echo ""
echo "Update Complete"
