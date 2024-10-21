#!/bin/sh
#

name="screen-4.6.2"

if [ -d /usr/local/src/screen* ]; 
then 
  echo "zsh directory exists"
  rm -rf /usr/local/src/screen*
  rm /usr/bin/screen
else 
  echo "zsh directory doesnt exist"
fi

cd /usr/local/src
wget http://ftp.gnu.org/gnu/screen/$name.tar.gz
tar xzf $name.tar.gz
rm $name.tar.gz
cd $name
./configure --with-socket-dir="/tmp/screens"
make
make install
ln -s /usr/local/src/$name/screen /usr/bin/screen
echo "Complete ****************"
