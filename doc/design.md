# create_firmware_ws

引入编译固件所需要的源代码

```text
colcon build
ros2 run micro_ros_setup create_firmware_ws.sh freertos nucleo_f767zi
# ws下会有一个firmware文件夹
zs@zs-3630:~/zs_ws/microros_ws$ ros2 run micro_ros_setup create_firmware_ws.sh nucleo_f767zi
Firmware already created. Please delete /home/zs/zs_ws/microros_ws/firmware folder if you want a fresh installation.
```

创建dev_ws和mcu_ws

在dev_ws中按照dev_ros2_packages.txt 下载ros2.repos代码，以及 dev_uros_packages.repos的代码

在mcu_ws中，按照client_ros2_packages.txt下载ros2.repos代码，以及 client_uros_packages.repos的代码

将client-colcon.meta拷贝到 mcu_ws/colcon.meta

在dev_ws中执行colcon build

执行rtos中的create.sh，create下载了交叉编译工具链arm-gcc，放置在toolchain文件夹

引入board.repos中的freertos_apps

避免交叉编译一些库

```bash
    touch mcu_ws/ros2/rcl_logging/rcl_logging_log4cxx/COLCON_IGNORE
    touch mcu_ws/ros2/rcl_logging/rcl_logging_spdlog/COLCON_IGNORE
    touch mcu_ws/ros2/rcl/COLCON_IGNORE
    touch mcu_ws/ros2/rosidl/rosidl_typesupport_introspection_cpp/COLCON_IGNORE
    touch mcu_ws/ros2/rcpputils/COLCON_IGNORE
    touch mcu_ws/uros/rcl/rcl_yaml_param_parser/COLCON_IGNORE
    touch mcu_ws/uros/rclc/rclc_examples/COLCON_IGNORE

```

# 单独建库

按照firmware根目录构建下列目录

![](https://tcs.teambition.net/storage/312f12d976e6678dfb118cba3b5efec32adc?Signature=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJBcHBJRCI6IjU5Mzc3MGZmODM5NjMyMDAyZTAzNThmMSIsIl9hcHBJZCI6IjU5Mzc3MGZmODM5NjMyMDAyZTAzNThmMSIsIl9vcmdhbml6YXRpb25JZCI6IiIsImV4cCI6MTY0NzI1NjQ3MywiaWF0IjoxNjQ2NjUxNjczLCJyZXNvdXJjZSI6Ii9zdG9yYWdlLzMxMmYxMmQ5NzZlNjY3OGRmYjExOGNiYTNiNWVmZWMzMmFkYyJ9.0lREYbRneea14N2ImVwYoXz8WkHQLhrmC7M5SUF0kTE&download=image.png "")

该目录下还有一个freertos_apps，子模块

## dev_ws

列表，方便交叉编译的脚本工具，交叉编译依赖

```text
repositories:
  ament/ament_cmake:
    type: git
    url: https://hub.fastgit.xyz/ament/ament_cmake.git
    version: galactic
  ament/ament_index:
    type: git
    url: https://hub.fastgit.xyz/ament/ament_index.git
    version: galactic
  ament/ament_lint:
    type: git
    url: https://hub.fastgit.xyz/ament/ament_lint.git
    version: galactic
  ament/ament_package:
    type: git
    url: https://hub.fastgit.xyz/ament/ament_package.git
    version: galactic
  ament/googletest:
    type: git
    url: https://hub.fastgit.xyz/ament/googletest.git
    version: galactic
  ament/uncrustify_vendor:
    type: git
    url: https://hub.fastgit.xyz/ament/uncrustify_vendor.git
    version: galactic
  ros2/ament_cmake_ros:
    type: git
    url: https://hub.fastgit.xyz/ros2/ament_cmake_ros.git
    version: galactic



```

编译选项-无

## mcu_ws

列表

```text
keep:
  ros2/rcl
  ros2/rmw
  ros2/rosidl_defaults
  ros2/rosidl
  ros2/rosidl_dds
  ros2/rmw_implementation
  ros2/common_interfaces
  ros2/libyaml_vendor
  ros2/rcl_interfaces
  ros2/unique_identifier_msgs
  ros2/rcl_logging
  ros2/test_interface_files
  ros2/example_interfaces
  ros2/rcpputils

```

```yaml
repositories:
  eProsima/Micro-CDR:
    type: git
    url: https://github.com/eProsima/Micro-CDR.git
    version: foxy
  eProsima/Micro-XRCE-DDS-Client:
    type: git
    url: https://github.com/eProsima/Micro-XRCE-DDS-Client.git
    version: foxy

# MicroROS
  uros/rcl:
    type: git
    url: https://github.com/micro-ROS/rcl
    version: galactic
  uros/rclc:
    type: git
    url: https://github.com/ros2/rclc
    version: galactic
  uros/micro_ros_utilities:
    type: git
    url: https://github.com/micro-ROS/micro_ros_utilities
    version: main
    version: galactic
  uros/rcutils:
    type: git
    url: https://github.com/micro-ROS/rcutils
    version: galactic
  uros/micro_ros_msgs:
    type: git
    url: https://github.com/micro-ROS/micro_ros_msgs.git
    version: galactic
  uros/rmw_microxrcedds:
    type: git
    url: https://github.com/micro-ROS/rmw-microxrcedds.git
    version: galactic
  uros/rosidl_typesupport:
    type: git
    url: https://github.com/micro-ROS/rosidl_typesupport.git
    version: galactic
  uros/rosidl_typesupport_microxrcedds:
    type: git
    url: https://github.com/micro-ROS/rosidl_typesupport_microxrcedds.git
    version: galactic
  uros/tracetools:
    type: git
    url: https://gitlab.com/micro-ROS/ros_tracing/ros2_tracing.git/
    version: galactic


```

编译选项

```json
{
    "names": {
        "tracetools": {
            "cmake-args": [
                "-DTRACETOOLS_DISABLED=ON",
                "-DTRACETOOLS_STATUS_CHECKING_TOOL=OFF"
            ]
        },
        "rcutils": {
            "cmake-args": [
                "-DENABLE_TESTING=OFF",
                "-DRCUTILS_NO_FILESYSTEM=ON",
                "-DRCUTILS_AVOID_DYNAMIC_ALLOCATION=ON",
                "-DRCUTILS_NO_64_ATOMIC=ON"
            ]
        },
        "microxrcedds_client": {
            "cmake-args": [
                "-DUCLIENT_PIC=OFF",
                "-DUCLIENT_PROFILE_DISCOVERY=OFF"
            ]
        },
        "rmw_microxrcedds": {
            "cmake-args": [
                "-DRMW_UXRCE_TRANSPORT=custom"
            ]
        },
        "tracetools": {
            "cmake-args": [
                "-DTRACETOOLS_DISABLED=ON",
                "-DTRACETOOLS_STATUS_CHECKING_TOOL=OFF"
            ]
        }
    }
}


```

## agent_ws

列表

```yaml
repositories:
  uros/micro_ros_msgs:
    type: git
    url: https://github.com/micro-ROS/micro_ros_msgs.git
    version: main
  uros/micro-ROS-Agent:
    type: git
    url: https://github.com/micro-ROS/micro-ROS-Agent.git
    version: main
  uros/drive_base:
    type: git
    url: https://github.com/micro-ROS/drive_base.git
    version: master

```

编译选项

无

# configure firmware

lish_apps.sh

```bash
. $PREFIX/config/$RTOS/list_apps.sh
check_available_app $1
```

configure.sh，本质上是更新colcon.meta，改变编译选项的宏定义

### 编译选项

注意，当使用serial的时候，xrcedds使用的custom transport

```bash
if [ "$UROS_TRANSPORT" == "udp" ]; then

      update_meta "rmw_microxrcedds" "RMW_UXRCE_TRANSPORT="$UROS_TRANSPORT
      update_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_IP="$UROS_AGENT_IP
      update_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_PORT="$UROS_AGENT_PORT

      update_meta "microxrcedds_client" "UCLIENT_PROFILE_CUSTOM_TRANSPORT=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_SERIAL=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_UDP=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_TCP=OFF"

      echo "Configured $UROS_TRANSPORT mode with agent at $UROS_AGENT_IP:$UROS_AGENT_PORT"

elif [ "$UROS_TRANSPORT" == "serial" ]; then
      echo "Using serial device USART."

      echo "Please check firmware/freertos_apps/microros_nucleo_f767zi_extensions/Src/main.c"
      echo "for configuring serial device before build."

      update_meta "microxrcedds_client" "UCLIENT_PROFILE_CUSTOM_TRANSPORT=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_STREAM_FRAMING=ON"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_SERIAL=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_UDP=OFF"
      update_meta "microxrcedds_client" "UCLIENT_PROFILE_TCP=OFF"

      update_meta "rmw_microxrcedds" "RMW_UXRCE_TRANSPORT=custom"

      remove_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_IP"
      remove_meta "rmw_microxrcedds" "RMW_UXRCE_DEFAULT_UDP_PORT"

      echo "Configured $UROS_TRANSPORT mode with agent at USART"
else

```

# build_firmware

stm43f767zi

根据build.sh和Makefile的过程来

## build.sh

```bash
. $FW_TARGETDIR/dev_ws/install/setup.bash


cd $FW_TARGETDIR/freertos_apps/microros_nucleo_f767zi_extensions
export UROS_APP_FOLDER="$FW_TARGETDIR/freertos_apps/apps/$UROS_APP"

rm -rf $FW_TARGETDIR/mcu_ws/build $FW_TARGETDIR/mcu_ws/install $FW_TARGETDIR/mcu_ws/log
make clean
make libmicroros

make -j$(nproc) UROS_APP_FOLDER=$UROS_APP_FOLDER

```

## toolchain

必须下载

```bash
https://developer.arm.com/-/media/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2

tar --strip-components=1 -xvjf gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 -C toolchain  > /dev/null
```

```bash
rm -f $(EXTENSIONS_DIR)/arm_toolchain.cmake; \
	cat $(EXTENSIONS_DIR)/arm_toolchain.cmake.in | \
		sed "s/@CROSS_COMPILE@/$(subst /,\/,$(CROSS_COMPILE))/g" | \
		sed "s/@FREERTOS_TOPDIR@/$(subst /,\/,$(TOPFOLDER))/g" | \
		sed "s/@ARCH_CPU_FLAGS@/\"$(ARCHCPUFLAGS)\"/g" | \
		sed "s/@ARCH_OPT_FLAGS@/\"$(ARCHOPTIMIZATION)\"/g" \
		> $(EXTENSIONS_DIR)/arm_toolchain.cmake

```

## colcon build

这个是构建uros的源码

```bash
colcon_compile: arm_toolchain
	cd $(UROS_DIR); \
	colcon build \
		--packages-ignore-regex=.*_cpp \
		--metas $(UROS_DIR)/colcon.meta $(UROS_APP_FOLDER)/app-colcon.meta \
		--cmake-args \
		"--no-warn-unused-cli" \
		-DCMAKE_POSITION_INDEPENDENT_CODE=OFF \
		-DTHIRDPARTY=ON \
		-DBUILD_SHARED_LIBS=OFF \
		-DBUILD_TESTING=OFF \
		-DCMAKE_BUILD_TYPE=$(BUILD_TYPE) \
		-DCMAKE_TOOLCHAIN_FILE=$(EXTENSIONS_DIR)/arm_toolchain.cmake \
		-DCMAKE_VERBOSE_MAKEFILE=ON; \

```

## libmicroros

构建libmicroros

```bash
mkdir -p $(UROS_DIR)/libmicroros; cd $(UROS_DIR)/libmicroros; \
	for file in $$(find $(UROS_DIR)/install/ -name '*.a'); do \
		folder=$$(echo $$file | sed -E "s/(.+)\/(.+).a/\2/"); \
		mkdir -p $$folder; cd $$folder; ar x $$file; \
		for f in *; do \
			mv $$f ../$$folder-$$f; \
		done; \
		cd ..; rm -rf $$folder; \
	done ; \
	ar rc libmicroros.a *.obj; mkdir -p $(BUILD_DIR); cp libmicroros.a $(BUILD_DIR); ranlib $(BUILD_DIR)/libmicroros.a; \
	cd ..; rm -rf libmicroros;

```

## app

供烧录的elf，链接了libmicroros

```text
all: $(BUILD_DIR)/$(TARGET).elf $(BUILD_DIR)/$(TARGET).hex $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: %.c Makefile | $(BUILD_DIR)
	$(CC) -c $(CFLAGS) -Wa,-a,-ad,-alms=$(BUILD_DIR)/$(notdir $(<:.c=.lst)) $< -o $@

$(BUILD_DIR)/%.o: %.s Makefile | $(BUILD_DIR)
	$(AS) -c $(CFLAGS) $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJECTS) Makefile
	$(CC) $(OBJECTS) $(LDFLAGS) -o $@
	$(SZ) $@

$(BUILD_DIR)/%.hex: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(HEX) $< $@

$(BUILD_DIR)/%.bin: $(BUILD_DIR)/%.elf | $(BUILD_DIR)
	$(BIN) $< $@

$(BUILD_DIR):
	mkdir $@

```

## 修改Makefile

```bash
# line 33
# TOPFOLDER = $(EXTENSIONS_DIR)/../../
TOPFOLDER = $(EXTENSIONS_DIR)/../../../..
UROS_APP = int32_publisher
UROS_APP_FOLDER = $(TOPFOLDER)/apps/$(UROS_APP)


which arm-none-eabi-gcc
/usr/bin/arm-none-eabi-gcc

# line: 189
# CROSS_COMPILE = $(TOPFOLDER)/toolchain/bin/$(CROSS_COMPILE_NAME_PREFIX)
CROSS_COMPILE = /usr/bin/$(CROSS_COMPILE_NAME_PREFIX)
CROSS_COMPILE = $(TOPFOLDER)/toolchain/gcc-arm-none-eabi-8-2019-q3-update/bin/$(CROSS_COMPILE_NAME_PREFIX)

```

## 修改源代码

部分xxx_vendor包需要下载github代码，被屏蔽，需手动修改

主要是libyaml_vendor

```bash
replace `URL https://github.com` with `URL https://hub.fastgit.xyz` for connection issue.
`GIT_REPOSITORY https://github.com` with `GIT_REPOSITORY https://hub.fastgit.xyz`
`curl https://github.com` with `curl https://hub.fastgit.xyz`
```

## build

```bash
# 避免source /opt/ros/galactic
cd ./dev_ws
colcon build

rm -rf $FW_TARGETDIR/mcu_ws/build $FW_TARGETDIR/mcu_ws/install $FW_TARGETDIR/mcu_ws/log

# 方便交叉编译源码
source ../../../../dev_ws/install/setup.bash

make clean
make libmicroros

make -j8

```

## 输出物

```text
/home/zs/zs_ws/ros2_mcu/extension/src/freertos_apps/microros_nucleo_f767zi_extensions/build/libmicroros.a
/home/zs/zs_ws/ros2_mcu/extension/src/freertos_apps/microros_nucleo_f767zi_extensions/build/micro-ROS.bin

```

# Flash

## st-link

```bash
sudo apt install stlink-tools
st-flash --reset write build/micro-ROS.bin 0x8000000

```

## openocd

```bash
if lsusb -d 0483:374b; then
        ST_INTERFACE=interface/stlink-v2-1.cfg
      elif lsusb -d 0483:3748; then
        ST_INTERFACE=interface/stlink-v2.cfg
      else
      # TODO: add stlink v3, should it be stlink.cfg ?
        echo "Error. Unsuported OpenOCD USB programmer"
        exit 1
      fi
openocd -f $ST_INTERFACE -f target/stm32f7x.cfg -c init -c "reset halt" -c "flash write_image erase build/micro-ROS.bin 0x08000000" -c "reset" -c "exit"

# 当前是stlink-v2-1的

```

# build_agent

```bash
echo "Building micro-ROS Agent"

colcon build --packages-up-to micro_ros_agent $@ --cmake-args \
    "-DUAGENT_BUILD_EXECUTABLE=OFF" \
    "-DUAGENT_P2P_PROFILE=OFF" \
    "--no-warn-unused-cli"
```

## 修改源代码

```bash
replace `URL https://github.com` with `URL https://hub.fastgit.xyz` for connection issue.
`GIT_REPOSITORY https://github.com` with `GIT_REPOSITORY https://hub.fastgit.xyz`
`curl https://github.com` with `curl https://hub.fastgit.xyz`

https://github.com        https://hub.fastgit.xyz
/home/zs/zs_ws/ros2_mcu/agent_ws/src/uros/micro-ROS-Agent/micro_ros_agent/cmake/SuperBuild.cmake

```

## build

```bash
# 不要source dev_ws
source /opt/ros/galactic/setup.bash
./build_agent.sh
```
