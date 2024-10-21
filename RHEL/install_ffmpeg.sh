#!/bin/sh
#

yum install autoconf automake bzip2 bzip2-devel cmake freetype-devel gcc gcc-c++ git libtool make mercurial pkgconfig zlib-devel -y

mkdir -vp /usr/local/src/ffmpeg_sources
mkdir -vp /usr/local/src/ffmpeg_build
ffmpegsource="/usr/local/src/ffmpeg_sources"
ffmpegbuild="/usr/local/src/ffmpeg_build"
bindir="/usr/local/src/bin"

# NASM
# An assembler used by some libraries. Highly recommended or your resulting build may be very slow.

cd ~/ffmpeg_sources
curl -O -L https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.bz2
tar xjvf nasm-2.15.05.tar.bz2
cd nasm-2.15.05
./autogen.sh
./configure --prefix="$ffmpegbuild" --bindir="$bindir"
make
make install

# Yasm
# An assembler used by some libraries. Highly recommended or your resulting build may be very slow.

cd ~/ffmpeg_sources
curl -O -L https://www.tortall.net/projects/yasm/releases/yasm-1.3.0.tar.gz
tar xzvf yasm-1.3.0.tar.gz
cd yasm-1.3.0
./configure --prefix="$ffmpegbuild" --bindir="$bindir"
make
make install
libx264

# H.264 video encoder. See the H.264 Encoding Guide for more information and usage examples.
# Requires ffmpeg to be configured with --enable-gpl --enable-libx264.

cd ~/ffmpeg_sources
git clone --depth 1 https://code.videolan.org/videolan/x264.git
cd x264
PKG_CONFIG_PATH="$ffmpegbuild/lib/pkgconfig" ./configure --prefix="$ffmpegbuild" --bindir="$bindir" --enable-static
make
make install
# Warning: If you get Found no assembler. Minimum version is nasm-2.13 or similar after running ./configure then the outdated nasm package from the repo is installed.
# Run yum remove nasm && hash -d nasm and x264 will then use your newly compiled nasm instead. 
# Ensure environment is able to resolve path to nasm binary.

# libx265
# H.265/HEVC video encoder. See the H.265 Encoding Guide for more information and usage examples.
# Requires ffmpeg to be configured with --enable-gpl --enable-libx265.

cd ~/ffmpeg_sources
hg clone https://bitbucket.org/multicoreware/x265
cd ~/ffmpeg_sources/x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="$ffmpegbuild" -DENABLE_SHARED:bool=off ../../source
make
make install

# libfdk_aac
# AAC audio encoder. See the AAC Audio Encoding Guide for more information and usage examples.
# Requires ffmpeg to be configured with --enable-libfdk_aac (and --enable-nonfree if you also included --enable-gpl).

cd ~/ffmpeg_sources
git clone --depth 1 https://github.com/mstorsjo/fdk-aac
cd fdk-aac
autoreconf -fiv
./configure --prefix="$ffmpegbuild" --disable-shared
make
make install

# libmp3lame
# MP3 audio encoder.
# Requires ffmpeg to be configured with --enable-libmp3lame.

cd ~/ffmpeg_sources
curl -O -L https://downloads.sourceforge.net/project/lame/lame/3.100/lame-3.100.tar.gz
tar xzvf lame-3.100.tar.gz
cd lame-3.100
./configure --prefix="$ffmpegbuild" --bindir="$bindir" --disable-shared --enable-nasm
make
make install

# libopus
# Opus audio decoder and encoder.
# Requires ffmpeg to be configured with --enable-libopus.

cd ~/ffmpeg_sources
curl -O -L https://archive.mozilla.org/pub/opus/opus-1.3.1.tar.gz
tar xzvf opus-1.3.1.tar.gz
cd opus-1.3.1
./configure --prefix="$ffmpegbuild" --disable-shared
make
make install

# libvpx
# VP8/VP9 video encoder and decoder. See the VP9 Video Encoding Guide for more information and usage examples.
# Requires ffmpeg to be configured with --enable-libvpx.

cd ~/ffmpeg_sources
git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git
cd libvpx
./configure --prefix="$ffmpegbuild" --disable-examples --disable-unit-tests --enable-vp9-highbitdepth --as=yasm
make
make install

# FFmpeg

cd ~/ffmpeg_sources
curl -O -L https://ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
tar xjvf ffmpeg-snapshot.tar.bz2
cd ffmpeg
PATH="$bindir:$PATH" PKG_CONFIG_PATH="$ffmpegbuild/lib/pkgconfig" ./configure \
  --prefix="$ffmpegbuild" \
  --pkg-config-flags="--static" \
  --extra-cflags="-I$ffmpegbuild/include" \
  --extra-ldflags="-L$ffmpegbuild/lib" \
  --extra-libs=-lpthread \
  --extra-libs=-lm \
  --bindir="$bindir" \
  --enable-gpl \
  --enable-libfdk_aac \
  --enable-libfreetype \
  --enable-libmp3lame \
  --enable-libopus \
  --enable-libvpx \
  --enable-libx264 \
  --enable-libx265 \
  --enable-nonfree
make
make install
hash -d ffmpeg