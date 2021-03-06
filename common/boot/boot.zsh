#!/usr/bin/env zsh
# author: bu6hunt3r

# $1 arg will be either null (nothing) or update, if make update was called
SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

# terminal colors (ANSI) like red, blue, magenta etc.
source $GIT_ROOT/common/zsh/termcolors.zsh

# constants will be defined in ~/.options
source $GIT_ROOT/common/zsh/constants.zsh

# checking if readlink command is present; aborting if not
source $GIT_ROOT/common/boot/guard.zsh

# defining functions verifylink build_git_url git_clone_error_msg dotgrab
source $GIT_ROOT/common/boot/functions.zsh $1

# Load custom shell options like prompt level, etc...
source ~/.options/shell-options.zsh

# Checking symlinks for repos within ~/.dotfiles
source $GIT_ROOT/common/boot/symlinks.zsh

source $GIT_ROOT/common/boot/zsh-deps.zsh
source $GIT_ROOT/common/boot/emacs-deps.zsh
source $GIT_ROOT/common/boot/other-deps.zsh
