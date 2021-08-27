#!/bin/sh
sudo apt-get install libeigen3-dev libcppunit-dev

cd MRSD_APPS
git clone https://github.com/orocos/orocos_kinematics_dynamics.git
cd orocos_kinematics_dynamics/orocos_kdl
mkdir build
cd build
cmake ..
sudo make install
cd




