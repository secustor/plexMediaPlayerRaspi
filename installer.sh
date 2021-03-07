#/bin/bash
# procedure source https://pimylifeup.com/raspberry-pi-plex-media-player/
# prepare packages
sudo apt update
sudo apt full-upgrade

sudo apt install -y autoconf make automake build-essential gperf yasm gnutls-dev libv4l-dev checkinstall libtool libtool-bin libharfbuzz-dev libfreetype6-dev libfontconfig1-dev libx11-dev libcec-dev libxrandr-dev libvdpau-dev libva-dev mesa-common-dev libegl1-mesa-dev yasm libasound2-dev libpulse-dev libbluray-dev libdvdread-dev libcdio-paranoia-dev libsmbclient-dev libcdio-cdda-dev libjpeg-dev libluajit-5.1-dev libuchardet-dev zlib1g-dev libfribidi-dev git libgnutls28-dev libgl1-mesa-dev libgles2-mesa-dev libsdl2-dev cmake python3 python python-minimal git mpv libmpv-dev


# build mpv
git clone https://github.com/mpv-player/mpv-build.git

cd mpv-build
echo --enable-libmpv-shared > mpv_options
echo --disable-cplayer >> mpv_options

./use-mpv-release
./use-ffmpeg-release

./rebuild -j$(nproc)

sudo ./install

sudo ldconfig


# install qt5
cd ~
wget https://github.com/koendv/qt5-opengl-raspberrypi/releases/download/v5.15.2-1/qt5-opengl-dev_5.15.2_armhf.deb
sudo apt-get install -y ./qt5-opengl-dev_5.15.2_armhf.deb
rm qt5-opengl-dev_5.15.2_armhf.deb


# build plex media player
git clone https://github.com/plexinc/plex-media-player
mkdir ~/plex-media-player/build
cd ~/plex-media-player/build

cmake -DCMAKE_BUILD_TYPE=Debug -DQTROOT=/usr/lib/qt5.15/ -DCMAKE_INSTALL_PREFIX=/usr/local/ ..

make -j$(nproc)

sudo make install
