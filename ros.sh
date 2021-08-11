#!/bin/sh
sudo apt-get update
sudo apt-get install ros-melodic-control*
sudo apt-get install ros-melodic-ros-control*
sudo apt install ros-melodic-rqt-joint-trajectory-controller
sudo apt-get install ros-melodic-ur-client-library
sudo apt-get install ros-melodic-industrial-robot-status-interface
sudo apt install ros-melodic-ddynamic-reconfigure

source /opt/ros/melodic/setup.bash
mkdir -p catkin_ws/src && cd catkin_ws/src

git clone https://github.com/ros-industrial/ur_msgs.git
git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git 
git clone -b calibration_devel https://github.com/fmauch/universal_robot.git 
cd ..
sudo apt update -qq
rosdep update
rosdep install --from-paths src --ignore-src -y
catkin_make
cd
