#!/usr/bin/env bash

# 添加用户和组权限，配置超级用户

addgroup --gid "$DOCKER_GRP_ID" "$DOCKER_GRP"
adduser --disabled-password --force-badname --gecos '' "$DOCKER_USER" \
    --uid "$DOCKER_USER_ID" --gid "$DOCKER_GRP_ID" 2>/dev/null
usermod -aG sudo "$DOCKER_USER"
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
cp -r /etc/skel/. /home/${DOCKER_USER}

# 删除一些目录
# rm -rf build/ devel/

# 更换国内源
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list
# sudo sed -i 's/packages.ros.org/mirrors.tuna.tsinghua.edu.cn/' /etc/apt/sources.list.d/ros1-latest.list


# 检测是16.04还是18.04

# case "$(lsb_release -r | cut -f2)" in
#     16.04)
#         echo '
#         source /opt/ros/kinetic/setup.bash
#         ' >> "/home/${DOCKER_USER}/.bashrc"
#         ;;
#     *)
#         echo '
#         source /opt/ros/melodic/setup.bash
#         ' >> "/home/${DOCKER_USER}/.bashrc"
#         ;;
# esac

# 设置bashrc
# echo '
# export ROS_WORKSPACE=/gpuac_ws
# export ROS_PACKAGE_PATH=${ROS_WORKSPACE}:${ROS_PACKAGE_PATH}
# export ROS_WORKSPACE=/gpuac_ws
# source ${ROS_WORKSPACE}/devel/setup.bash

# # ga_config
# export GA_ENABLE_LOG_TO_A_FILE="./log/ga.log"
# export GA_ENABLE_LOG_TO_STDOUT=1
# export GA_LOG_LEVEL='i'

# ulimit -c unlimited

# export PATH=${PATH}:/gpuac_ws/src/gpuac/gpuac_launch/scripts:/usr/local/miniconda/bin

# # cuda
# export PATH=${PATH}:/usr/local/cuda-10.0/bin
# export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-10.0/lib64

# if [ -e "/gpuac/gpuac_launch/scripts/ga_base.sh" ]; then
#   source /gpuac/gpuac_launch/scripts/ga_base.sh
# fi

# ' >> "/home/${DOCKER_USER}/.bashrc"

echo '
genhtml_branch_coverage = 1
lcov_branch_coverage = 1
' > "/home/${DOCKER_USER}/.lcovrc"

# Set user files ownership to current user, such as .bashrc, .profile, etc.
chown ${DOCKER_USER}:${DOCKER_GRP} /home/${DOCKER_USER}
ls -ad /home/${DOCKER_USER}/.??* | xargs chown -R ${DOCKER_USER}:${DOCKER_GRP}

# 配置一些设备最基本的属性

# setup GPS device
if [ -e /dev/novatel0 ]; then
  chmod a+rw /dev/novatel0
fi
if [ -e /dev/novatel1 ]; then
  chmod a+rw /dev/novatel1
fi
if [ -e /dev/novatel2 ]; then
  chmod a+rw /dev/novatel2
fi
if [ -e /dev/ttyACM0 ]; then
  chmod a+rw /dev/ttyACM0
fi

# setup camera device
if [ -e /dev/camera/obstacle ]; then
  chmod a+rw /dev/camera/obstacle
fi
if [ -e /dev/camera/trafficlights ]; then
  chmod a+rw /dev/camera/trafficlights
fi
