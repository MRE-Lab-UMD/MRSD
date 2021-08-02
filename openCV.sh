#!/bin/sh
export WORKSPACE=$HOME/catkin_ws
cd $WORKSPACE/src/
git clone --------------insert ur5_project link here-------------------------






rosws init -c $SBR_WORKSPACE/src/sbr /opt/ros/`rosversion -d`
cd $SBR_WORKSPACE
cd src/sbr
curl -s https://www.cs.jhu.edu/~sleonard/assignment1.tgz | tar xvfz - -C $SBR_WORKSPACE/src/sbr/
rosws set -y robotiq https://github.com/ros-industrial/robotiq.git --git --version=`rosversion -d`-devel
rosws set -y universal_robot https://github.com/ros-industrial/universal_robot.git --git --version=`rosversion -d`-devel
rosws update robotiq universal_robot
cd $SBR_WORKSPACE
catkin build

