#! /bin/bash

set -e
set -o nounset
set -o pipefail

vcs import --input board.repos ./src --skip-existing
