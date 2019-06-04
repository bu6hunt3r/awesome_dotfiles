#!/usr/bin/env zsh
# author: bu6hunt3r

SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

# terminal colors (ANSI) like red, blue, magenta etc.
source $GIT_ROOT/zsh/termcolors.zsh

# constants will be defined in ~/.options
source $GIT_ROOT/zsh/constants.zsh
