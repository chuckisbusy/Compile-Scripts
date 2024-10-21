#!/bin/sh
#

name="transmission-2.94"
cd /usr/local/src
wget https://github.com/transmission/transmission-releases/raw/master/$name.tar.xz
tar -xvf $name.tar.xz
rm $name.tar.xz
cd $name
yum install libcurl.x86_64 libcurl.i686 libcurl-devel libevent libevent-devel libevent2 libevent2-devel -y
./configure
make
make install
echo "Type:
iptables -A INPUT -p tcp --dport 9091 -j ACCEPT
service iptables restart"
