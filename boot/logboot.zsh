#!/usr/bin/env zsh
# author: bu6hunt3r

SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)

echo $PWD

logdir=$GIT_ROOT/boot/log
mkdir -p $logdir

logfile=$logdir/boot.log

echo "\033[1;33m[INFO]\033[0m Log will be written into \033[1;32m$logfile\033[0m"

./boot.zsh $1 2>&1 | tee $logfile