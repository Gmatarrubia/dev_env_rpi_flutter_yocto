#!/bin/bash

currentPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

pushd raspberrypi3/tmp-glibc/deploy/images/raspberrypi3 || return
bmaptool copy core-image-minimal-raspberrypi3.wic.bz2 "${currentPath}"/disk.img
popd || return