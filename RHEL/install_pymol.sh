#!/bin/sh
#

prefix="/usr/local/src/pymol"
modules=$prefix/modules

yum install pyqt4 gcc gcc-c++ kernel-devel python-devel tkinter python-pmw glew-devel \
  freeglut-devel libpng-devel freetype-devel libxml2-devel glm-devel

cd /usr/local/src/
git clone https://github.com/schrodinger/pymol-open-source.git
cd pymol-open-source
rm -rf build
#python27 setup.py install --glut
python setup.py install