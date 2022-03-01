#! /bin/bash

set -e
set -o nounset
set -o pipefail

# ignore broken packages
touch ./src/ros2/rcl_logging/rcl_logging_log4cxx/COLCON_IGNORE
touch ./src/ros2/rcl_logging/rcl_logging_spdlog/COLCON_IGNORE
touch ./src/ros2/rcl/COLCON_IGNORE
touch ./src/ros2/rosidl/rosidl_typesupport_introspection_cpp/COLCON_IGNORE
touch ./src/ros2/rcpputils/COLCON_IGNORE
touch ./src/uros/rcl/rcl_yaml_param_parser/COLCON_IGNORE
touch ./src/uros/rclc/rclc_examples/COLCON_IGNORE