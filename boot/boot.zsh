#!/usr/bin/env zsh
# author: bu6hunt3r

# $1 arg will be either null (nothing) or update, if make update was called
SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

# terminal colors (ANSI) like red, blue, magenta etc.
source $GIT_ROOT/zsh/termcolors.zsh

# constants will be defined in ~/.options
source $GIT_ROOT/zsh/constants.zsh

# checking if readlink command is present; aborting if not
source $GIT_ROOT/boot/guard.zsh

# defining functions verifylink build_git_url git_clone_error_msg dotgrab
source $GIT_ROOT/boot/functions.zsh $1




