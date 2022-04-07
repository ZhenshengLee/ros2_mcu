#!/bin/bash

set +o nounset
. /opt/ros/galactic/setup.bash
set -o nounset

colcon build --metas ./ros2-colcon.meta src --cmake-args -DBUILD_TESTING=OFF $@
