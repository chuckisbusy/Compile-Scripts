#!/bin/sh
#

# Install dependencies (if needed)
yum install -y xorg-x11-fonts-75dpi xorg-x11-fonts-Type1

# Get latest version of wkhtmltopdf (replace version number if needed)
wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

# Untar and move wkhtmltox, create symlink
tar -xf ${name}.tar.xz
mv wkhtmltox /usr/bin/wkhtmltox
ln -s /usr/bin/wkhtmltox/bin/wkhtmltopdf /usr/bin/wkhtmltopdf 