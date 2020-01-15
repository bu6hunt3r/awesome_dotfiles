#!/usr/bin/env zsh
# author: bu6hunt3r

SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

printf "\e[1;33m%s\e[m %s\n" "[INFO]" "Chdir into $PWD"

logdir=$GIT_ROOT/common/boot/log
mkdir -p $logdir

logfile=$logdir/boot.log

printf "\e[1;33m%s\e[m %s\n" "[INFO]" "Log will be written into $logfile"

./boot.zsh $1 2>&1 | tee $logfile
