#!/bin/bash

set +o nounset
. ../host_ws/install/setup.bash
set -o nounset

UROS_DIR=../host_ws
UROS_APP=int32_publisher
UROS_APP_FOLDER=${UROS_DIR}/app_ws/src/${UROS_APP}

colcon build --metas ${UROS_DIR}/colcon.meta ./host-app-colcon.meta src --cmake-args -DBUILD_TESTING=OFF $@
# colcon build --metas ${UROS_DIR}/colcon.meta ${UROS_APP_FOLDER}/app-colcon.meta src --cmake-args -DBUILD_TESTING=OFF $@
