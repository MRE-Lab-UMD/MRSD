#!/bin/sh
sudo apt-get update
sudo apt-get install ros-melodic-control*
sudo apt-get install ros-melodic-ros-control*
sudo apt install ros-melodic-rqt-joint-trajectory-controller

source /opt/ros/noetic/setup.bash
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/
catkin_make
cd

cd ~/catkin_ws/src
git clone https://github.com/ros-industrial/ur_msgs.git
git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git 
cd
