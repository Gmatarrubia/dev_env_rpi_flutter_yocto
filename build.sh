#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

export MACHINE=raspberrypi3
rm -f "$MACHINE/conf/local.conf"

source ./setup-environment "$MACHINE"

echo '***************************************'
echo -e 'CONNECTIVITY_CHECK_URIS = "https://www.yoctoproject.org/"' >> conf/local.conf
echo -e 'DISTRO = "flutterpi"' >> ./conf/local.conf
echo -e "DL_DIR = \"$repoPath/dl\"" >> ./conf/local.conf
echo -e "SSTATE_DIR = \"$repoPath/sstate\"" >> ./conf/local.conf
echo -e "SSTATE_MIRRORS = \"file://.* file://$repoPath/sstate/PATH\"" >> ./conf/local.conf
echo -e 'SSTATE_MIRRORS += "file://.* http://sstate.yoctoproject.org/honister/PATH;downloadfilename=PATH"' >> ./conf/local.conf

bitbake-layers add-layer ../meta-config-pi
bitbake-layers add-layer ../meta-flutter-app

##NOTE Enable verbose option
#echo '********** ./conf/local.conf **********'
#cat ./conf/local.conf
#echo '***************************************'
#bitbake-layers show-layers
#echo '***************************************'
#bitbake -e virtual/kernel | grep "^PV"
#bitbake -e virtual/kernel | grep "^PN"
#echo '***************************************'
#bitbake -e core-image-minimal | grep "^DISTRO_FEATURES"
#echo '***************************************'
bitbake -e > bb.environment
#bitbake rpi-weather -D
time bitbake core-image-minimal
