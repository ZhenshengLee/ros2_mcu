cmake_minimum_required(VERSION 3.13)

project(micro_ros_ertps_test LANGUAGES CXX)

if(NOT CMAKE_CXX_STANDARD)
  set(CMAKE_CXX_STANDARD 14)
endif()

find_package(ament_cmake REQUIRED)
find_package(fastrtps_cmake_module REQUIRED)
find_package(fastcdr REQUIRED CONFIG)
find_package(fastrtps 2.3 REQUIRED CONFIG)
find_package(FastRTPS 2.3 REQUIRED MODULE)

include_directories(include)

add_executable(ertps_test "src/main.cpp" "src/rtps.cpp")
target_link_libraries(ertps_test fastcdr fastrtps)

ament_target_dependencies(ertps_test
  fastrtps
  fastcdr
  )

install(TARGETS ertps_test
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib
  RUNTIME DESTINATION bin
)

ament_package()
