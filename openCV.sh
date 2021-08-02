#!/bin/sh
cd ~/MRSD_APPS/opencv-4.5.2
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
sudo make install
