#!/usr/bin/env bash

MY_COMMAND=readlink

if ! command -v $MY_COMMAND &> /dev/null; then
    echo "\033[1;33m[STATUS - $0]\033[0m $MY_COMMAND command not found. aborting"
    exit 1;
else
    echo "\033[1;33m[STATUS - $0]\033[0m $MY_COMMAND command found. continuing"
fi