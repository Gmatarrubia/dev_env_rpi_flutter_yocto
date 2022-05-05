#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

echorun() {
    echo "$@"
    "$@"
}

echorun rm -rf manifest
echorun rm -rf .repo
echorun rm -rf raspberrypi3
echorun rm -rf sources
#echorun rm -rf dl
#echorun rm -rf sstate