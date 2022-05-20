#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"
source checkFunctions.sh

# Script arguments handle
__verbose=
__bitbake_cmd=
__only_shell=

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
        --shell)
            __only_shell=1
            echo "Only shell mode"
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
    esac
    shift
done

# Start configuration
export MACHINE=raspberrypi3
export CONF_FILE="${repoPath}/rpi-flutter.yml"
export KAS_BUILD_DIR="${repoPath}/${MACHINE}"
export DL_DIR="${repoPath}/dl"
export SSTATE_DIR="${repoPath}/sstate"
export SHELL="/bin/bash"
rm -rf "${MACHINE}"/conf/*

#Check availability of the kas tool
check_kas

# Check if sources were downloaded
if [ ! -d "${repoPath}/sources" ]
then
    source ./start-environment "${CONF_FILE}"
fi

##NOTE Enable verbose option
if [ -n  "${__verbose}" ]
then
    echo '***************************************'
    kas shell -c "bitbake-layers show-layers"
    echo '***************************************'
    kas shell -c "bitbake -e virtual/kernel | grep '^PV'"
    kas shell -c "bitbake -e virtual/kernel | grep '^PN'"
    echo '***************************************'
    kas shell -c "bitbake -e" > bb.environment
fi

if [ -n "${__only_shell}" ]
then
    kas shell -E "${CONF_FILE}"
    exit 0
fi

###Enable option for only start
if [ -z "${__bitbake_cmd[*]}" ]
then
    time kas build "${CONF_FILE}"
else
    echo "Executing command: ${__bitbake_cmd[*]}"
    time kas shell -c "${__bitbake_cmd[@]}"
fi
