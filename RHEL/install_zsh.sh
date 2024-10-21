#!/bin/sh
#

name="zsh-5.8"

### Delete previous zsh installation
rm -rf /usr/local/src/zsh*
rm /usr/local/bin/zsh
rm /usr/bin/zsh

yum install ncurses ncurses-devel -y
cd /usr/local/src
wget -O $name.tar.xz https://sourceforge.net/projects/zsh/files/zsh/5.8/zsh-5.8.tar.xz/download
tar xvf $name.tar.xz
rm $name.tar.xz
cd $name
./configure
make
make install
echo /usr/local/bin/zsh >> /etc/shells
echo "Complete! ****************"
