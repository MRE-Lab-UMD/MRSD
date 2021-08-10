#!/bin/sh
cd MRSD_APPS
git clone https://github.com/biggunray/reflexxes_type2.git
cd reflexxes_type2
mkdir build
cd build
cmake ..
sudo make install
cd




