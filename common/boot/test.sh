#!/usr/bin/env zsh
# author: bu6hunt3r

# $1 arg will be either null (nothing) or update, if make update was called
SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

echo -e "${SCRIPTPATH%%boot}"
echo "$GIT_ROOT"
