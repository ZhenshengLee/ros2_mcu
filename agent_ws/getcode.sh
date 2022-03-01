#! /bin/bash

set -e
set -o nounset
set -o pipefail

if [ -f ros2.repos ]
then
    echo "Repo-file ros2.repos already present, overwriting!"
fi

cat ../ros2-dev.repos |\
    python3 ../yaml_filter.py ./agent_ros2_packages.txt > ros2.repos
vcs import --input ros2.repos ./src --skip-existing
vcs import --input ./agent_uros_packages.repos ./src --skip-existing
