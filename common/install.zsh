#!/usr/bin/env zsh
# author: bu6hunt3r
#
SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

./boot/logboot.zsh $1
