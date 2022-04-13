#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

export MACHINE=raspberrypi3-64

source ./setup-environment "$MACHINE"
echo -e 'CORE_IMAGE_EXTRA_INSTALL += " \' >> conf/local.conf
echo -e '  flutter-pi \' >> conf/local.conf
echo -e '  flutter-drm-gbm-backend \' >> conf/local.conf
echo -e '"\n' >> conf/local.conf
echo -e 'CONNECTIVITY_CHECK_URIS = "https://www.yoctoproject.org/"' >> conf/local.conf


echo '***************************************'
echo -e "DL_DIR = \"$repoPath/dl\"" >> ./conf/local.conf
echo -e "SSTATE_DIR = \"$repoPath/sstate\"" >> ./conf/local.conf
echo -e "SSTATE_MIRRORS = \"file://.* file://$repoPath/sstate/PATH\"" >> ./conf/local.conf
echo -e 'SSTATE_MIRRORS += "file://.* http://sstate.yoctoproject.org/honister/PATH;downloadfilename=PATH"' >> ./conf/local.conf
echo -e 'IMAGE_LINGUAS = "es-Es"' >> ./conf/local.conf
echo -e 'PACKAGECONFIG:pn-sascha-samples = "d2d"' >> ./conf/local.conf
echo -e 'PACKAGECONFIG:pn-vkcube = "kms wayland"' >> ./conf/local.conf
echo -e 'PREFERRED_PROVIDER:jpeg = "libjpeg-turbo"' >> ./conf/local.conf
echo -e 'PREFERRED_PROVIDER:jpeg-native = "libjpeg-turbo-native"' >> ./conf/local.conf
echo -e '' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:vulkan-headers = "1.2.198.0"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:vulkan-loader = "1.2.198.1"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:vulkan-tools = "1.2.198.0"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:glslang = "11.6.0"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:vulkan-validationlayers = "1.2.198"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:cmake = "3.21.1"' >> ./conf/local.conf
echo -e 'PREFERRED_VERSION:cmake-native = "3.21.1"' >> ./conf/local.conf
echo '********** ./conf/local.conf **********'
cat ./conf/local.conf
echo '***************************************'
bitbake-layers remove-layer meta-flutter
bitbake-layers add-layer ../../meta-flutter
bitbake-layers show-layers
echo '***************************************'
bitbake -e virtual/kernel | grep "^PV"
bitbake -e virtual/kernel | grep "^PN"
echo '***************************************'
bitbake -e core-image-minimal | grep "^DISTRO_FEATURES"
echo '***************************************'
bitbake -e > bb.environment

bitbake core-image-minimal