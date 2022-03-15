cmake_minimum_required(VERSION 3.5)

project(micro_ros_lifecycle_node LANGUAGES C)

find_package(ament_cmake REQUIRED)
find_package(rcl REQUIRED)
find_package(rcl_lifecycle REQUIRED)
find_package(rclc REQUIRED)
find_package(rclc_lifecycle REQUIRED)
find_package(rclc_parameter REQUIRED)
find_package(std_msgs REQUIRED)
find_package(example_interfaces REQUIRED)
find_package(rmw_microxrcedds REQUIRED)

set(EXE_NAME lifecycle_node)
add_executable(${EXE_NAME} app.c)

ament_target_dependencies(${EXE_NAME}
  rcl
  rclc
  std_msgs
  rmw_microxrcedds
  rcutils
  rcl_lifecycle
  rclc_lifecycle
  lifecycle_msgs
  )

install(TARGETS ${EXE_NAME}
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
