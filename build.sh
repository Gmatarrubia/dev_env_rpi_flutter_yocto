#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

# Script arguments handle
__verbose=
__bitbake_cmd=

while (( $# )); do
    case ${1,,} in
        -v|--verbose)
            __verbose=1
            echo "Verbose output enabled"
            ;;
        -bc|--bitbake-cmd)
            shift
            __bitbake_cmd=("${@}")
            echo Custom bitbake command: "${__bitbake_cmd[@]}"
            ;;
    esac
    shift
done

# Check if sources were downloaded
if [ ! -d "${repoPath}/sources" ]
then
    "${repoPath}"/getSources.sh
fi

# Start configuration
export MACHINE=raspberrypi3
rm -rf "${MACHINE}"/conf/*

source ./start-environment "$MACHINE"
echo '***************************************'

# Write config in conf/local.conf
{ \
echo -e 'CONNECTIVITY_CHECK_URIS = "https://www.yoctoproject.org/"';
echo -e 'DISTRO = "flutterpi"';
echo -e "DL_DIR = \"$repoPath/dl\""; \
echo -e "SSTATE_DIR = \"$repoPath/sstate\"";
echo -e "SSTATE_MIRRORS = \"file://.* file://$repoPath/sstate/PATH\"";
echo -e 'SSTATE_MIRRORS += "file://.* http://sstate.yoctoproject.org/honister/PATH;downloadfilename=PATH"';
} >> ./conf/local.conf

##NOTE Enable verbose option
if [ -n  "${__verbose}" ]
then
    echo '***************************************'
    bitbake-layers show-layers
    echo '***************************************'
    bitbake -e virtual/kernel | grep "^PV"
    bitbake -e virtual/kernel | grep "^PN"
    echo '***************************************'
    bitbake -e > bb.environment
fi

###Enable option for only start

if [ -z "${__bitbake_cmd[*]}" ]
then
    time bitbake core-image-minimal
else
    echo "Executing command: ${__bitbake_cmd[*]}"
    time "${__bitbake_cmd[@]}"
fi
