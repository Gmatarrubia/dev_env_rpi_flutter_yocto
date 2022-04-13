#!/bin/bash

export MACHINE=raspberrypi3-64

source ./setup-environment "$MACHINE"
echo -e 'CORE_IMAGE_EXTRA_INSTALL += " \' >> conf/local.conf
echo -e '  flutter-pi \' >> conf/local.conf
echo -e '  flutter-drm-gbm-backend \' >> conf/local.conf
echo -e '"\n' >> conf/local.conf
bitbake core-image-minimal