#/bin/bash
#
# Reference: http://intbio.org/jekyll/update/2018/11/23/vmd.html
# Reference: https://www.ks.uiuc.edu/Research/vmd/mailing_list/vmd-l/31210.html
#
# You need vmd-1.9.3.src.tar & surf_MACOSXX86_64 in Downloads folder
# DO NOT RUN WITH SUDO !!!
#

export OSX_VER=10.15.6

brew install netcdf tcl-tk povray libpng
mkdir -p /Users/chuck/bin/vmd/
tar -xf /Users/chuck/Downloads/vmd-1.9.3.src.tar -C /Users/chuck/bin/vmd/

#compiling fltk development version
cd /Users/chuck/bin/vmd/vmd-1.9.3/lib/fltk
mkdir -p MACOSXX86_64
wget https://www.fltk.org/pub/fltk/snapshots/fltk-1.4.x-20200214-975acb32.tar.gz
tar -xf fltk-1.4.x-20200214-975acb32.tar.gz
ln -s fltk-1.4.x-20200214-975acb32 fltk
ln -s fltk include
cd fltk
sudo make clean
sudo ./configure --prefix="$PWD/../MACOSXX86_64" --exec-prefix="$PWD/../MACOSXX86_64" --libdir="$PWD/../MACOSXX86_64" CXXFLAGS="-mmacosx-version-min=$OSX_VER" LDFLAGS="-mmacosx-version-min=$OSX_VER"
sudo make -j 8
sudo make install

#compile stride
cd /Users/chuck/bin/vmd/vmd-1.9.3/lib/stride
wget http://webclu.bio.wzw.tum.de/stride/stride.tar.gz
tar -zxf stride.tar.gz
sudo make
mv stride stride_MACOSXX86_64

#get surf
cp -rp ~/Downloads/surf_MACOSXX86_64 ~/bin/vmd/vmd-1.9.3/lib/surf

#compile actc
cd /Users/chuck/bin/vmd/vmd-1.9.3/lib
mkdir -p actc && cd $_
wget https://downloads.sourceforge.net/project/actc/actc-source/1.1-final/actc-1.1.tar.gz
tar -xf actc-1.1.tar.gz
ln -s actc-1.1 include
ln -s actc-1.1 lib_MACOSXX86_64
cd actc-1.1
sed -i.bak 's%#include <malloc.h>%%g' tctest2.c
sudo make CFLAGS=-D__linux__

#compile tachyon
cd /Users/chuck/bin/vmd/vmd-1.9.3/lib/tachyon
wget http://www.photonlimited.com/~johns/tachyon/files/0.99b6/tachyon-0.99b6.tar.gz
tar -xf tachyon-0.99b6.tar.gz
cd tachyon/unix
sudo make linux-64
cd /Users/chuck/bin/vmd/vmd-1.9.3/lib/tachyon
ln -s tachyon/src include
ln -s tachyon/compile/linux-64 lib_MACOSXX86_64
cp tachyon/compile/linux-64/tachyon tachyon_MACOSXX86_64

#compiling vmd plugins
cd /Users/chuck/bin/vmd/plugins
export PLUGINDIR="/Users/chuck/bin/vmd/vmd-1.9.3/plugins"
export TCLINC=-I/usr/local/opt/tcl-tk/include
export TCLLIB=-L/usr/local/opt/tcl-tk/lib
export NETCDFINC=-I/usr/local/opt/netcdf/include
export NETCDFLIB=-L/usr/local/opt/netcdf/lib
export PNGINC=-I/usr/local/opt/libpng/include
export PNGLIB=-L/usr/local/opt/libpng/lib
sudo make MACOSXX86_64 TCLINC=$TCLINC TCLLIB=$TCLLIB NETCDFINC=$NETCDFINC NETCDFLIB=$NETCDFLIB "NETCDFLDFLAGS = -lnetcdf" PNGINC=$PNGINC PNGLIB=$PNGLIB "USEPNG = -DUSEPNG"
make distrib

cd /Users/chuck/bin/vmd/vmd-1.9.3
echo "MACOSXX86_64 LP64 FLTKOPENGL FLTK TK  TCL PTHREADS ACTC  LIBTACHYON  LIBPNG NETCDF " > configure.options

#Fix code
sed -i.bak 's/MACOSX/MACOSXX86/g' bin/vmd.sh
sed -i.bak 's/MACOSX/MACOSXX86/g' bin/vmd.csh
sudo ./configure 
cd src
sed -i.bak 's/fltk-1.3.x/fltk/g' Makefile
sed -i.bak 's%../lib/tk/lib_MACOSXX86_64/Tk.framework/Versions/8.5/Headers%/usr/local/opt/tcl-tk/include%g' Makefile
sed -i.bak "s%../lib/netcdf/include%/usr/local/opt/netcdf/include%g" Makefile
sed -i.bak "s%../lib/netcdf/lib_MACOSXX86_64%/usr/local/opt/netcdf/lib%g" Makefile
sed -i.bak "s%../lib/tcl/lib_MACOSXX86_64%/usr/local/opt/tcl-tk/lib%g" Makefile
sed -i.bak "s%../lib/tcl/include%/usr/local/opt/tcl-tk/include%g" Makefile
sed -i.bak "s%../lib/tk/lib_MACOSXX86_64%/usr/local/opt/tcl-tk/lib%g" Makefile
sed -i.bak "s%../lib/netcdf/lib_LINUXAMD64%/usr/local/opt/netcdf/lib%g" Makefile

cat << EOF > /Users/chuck/bin/vmd/vmd-1.9.3/src/vmdmac.r
data 'MBAR' (128) { 
        $"0001 0080" /* ...\200 */ 
}; 
data 'MENU' (128, "Apple") { 
        $"0080 0000 0000 0000 0000 FFFF FFFB 0114" /* .\200........\3 
77\377\377\373.. */ 
        $"0A41 626F 7574 2046 4C54 4B00 0000 0001" /* \302About FLTK. 
.... */ 
        $"2D00 0000 0000" /* -..... */ 
}; 
data 'carb' (0) { 
}; 
EOF

sudo make veryclean
sudo make -j 8
sudo make install