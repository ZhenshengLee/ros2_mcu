#!/usr/bin/env bash

# 进入某个容器
# 必须制定一个参数：容器名
# 选择制定一个参数：是否root，默认非root

GA_DIST=""

function show_usage()
{
cat <<EOF
Usage: $(basename $0) [options] ...
OPTIONS:
    -d 18.04
    -d 16.04
EOF
exit 0
}

# 参数校验
while [ $# -gt 0 ]
do
    case "$1" in
    -d|--dist)
        VAR=$1
        GA_DIST=$VAR
        ;;
    -h|--help)
        show_usage
        ;;
    stop)
    stop_containers
    exit 0
    ;;
    *)
        echo -e "\033[93mWarning\033[0m: Unknown option: $1"
        exit 2
        ;;
    esac
    shift
done

# zs:
# 如果没有制定,默认是18.04
if [ -z "${GA_DIST}" ]; then
    GA_DIST=18.04
else
    GA_DIST=16.04
fi

xhost +local:root 1>/dev/null 2>&1
docker exec \
    -u zs \
    -e HISTFILE=/gpuac_ws/src/gpuac/.dev_bash_hist \
    -it ga_all_${GA_DIST}_yx \
    /bin/bash

# docker exec \
#     -u root \
#     -e HISTFILE=/gpuac/.dev_bash_hist \
#     -it ga_all_18.04_$USER \
#     /bin/bash

xhost -local:root 1>/dev/null 2>&1