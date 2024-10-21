#!/bin/sh
#

yum install gcc-c++ autoconf automake libxml2-devel openssl-devel sqlite-devel lm_sensors lm_sensors-devel avahi-devel -y

name='istatserver-3.02'
cd /usr/local/src
wget https://files.bjango.com/istatserverlinux/$name.tar.gz
tar xzf $name.tar.gz
rm $name.tar.gz
cd $name 
./autogen
./configure
make
make install
cp ./resource/systemd/istatserver.service /etc/systemd/system/istatserver.service
systemctl enable istatserver
systemctl start istatserver
echo Complete!
#grep -w /usr/local/etc/istatserver/istatserver.conf -e server_code | grep -v "#" | sed -e "s/server_code//g" | sed -e 's/[ \t]//g'
grep -w /usr/local/etc/istatserver/istatserver.conf -e server_code | grep -v "#"