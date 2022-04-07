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

touch ./src/ros2/geometry2/examples_tf2_py/COLCON_IGNORE
touch ./src/ros2/geometry2/test_tf2/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_bullet/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_eigen/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_eigen_kdl/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_geometry_msgs/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_kdl/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_py/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_ros/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_ros_py/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_sensor_msgs/COLCON_IGNORE
touch ./src/ros2/geometry2/tf2_tools/COLCON_IGNORE