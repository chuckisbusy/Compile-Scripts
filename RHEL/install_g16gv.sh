#!/bin/bash
##

g16root="/usr/local/src/"
GAUSS_SCRIDIR="/tmp/g16scratch/"
export g16root GAUSS_SCRIDIR 

cp /home/cad234/Software/Gaussian/E6L-511X.tbz /usr/local/src
cd /usr/local/src
tar -xvjf E6L-511X.tbz
rm E6L-511X.tbz
cd g16
./bsd/install


cp /home/cad234/Software/Gaussian/gv6.tar.bz2 /usr/local/src
tar xvf gv6.tar.bz2
rm gv6.tar.bz2


cd /usr/local/src
echo "Number of .exe should be 85: "
ls $g16root/g16/*.exe | wc -l
chown -R cad234:cad234 g16
chown -R root:root gv
chmod -R o=g gv
