cmake_minimum_required(VERSION 3.5)

project(micro_ros_int32_publisher LANGUAGES C)

find_package(ament_cmake REQUIRED)
find_package(rcl REQUIRED)
find_package(rclc REQUIRED)
find_package(std_msgs REQUIRED)
find_package(rmw_microxrcedds REQUIRED)

add_executable(int32_publisher app.c)

ament_target_dependencies(int32_publisher
  rcl
  rclc
  std_msgs
  rmw_microxrcedds
  )

install(TARGETS int32_publisher
  DESTINATION lib/${PROJECT_NAME}
)

ament_package()
