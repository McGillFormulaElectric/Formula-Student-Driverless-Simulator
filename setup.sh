#!/usr/bin/bash 

ROS_DISTRO=humble
ROS_INSTALL=/opt/ros/$ROS_DISTRO/setup.bash

source $ROS_INSTALL

# 1) Source base ROS 2
if [ -f "$ROS_INSTALL" ]; then
  echo -e "\n=== Sourcing ROS 2 base ($ROS_DISTRO) ==="
  set +u
  source "$ROS_INSTALL"
  set -u
else
  echo "ERROR: cannot find ROS install at $ROS_INSTALL" >&2
  exit 1
fi

echo "Configuring Simulator: Checking if binaries are installed."
if [ ! -f ./FSDS.sh  ] && [ ! -f ./FSDS.exe  ];
then
    echo "Binaries not installed, make sure you follow the tutorial at:"
    echo "https://github.com/McGillFormulaElectric/MFE-Driverless-V1/wiki/Simulation"
fi

colcon build --symlink-install

source install/setup.bash

ros2 run fsds_ros2_bridge fsds_ros2_bridge manual_node:=true