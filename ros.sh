#!/bin/sh
sudo apt-get update
sudo apt-get install ros-melodic-control*
sudo apt-get install ros-melodic-ros-control*

cd ~catkin_ws/src
git clone https://github.com/ros-industrial/ur_msgs.git
git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git 
cd ..
source ~catkin_ws/devel/setup.bash
echo "source ~catkin_ws/devel/setup.bash" >> ~/.bashrc
