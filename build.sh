#!/bin/bash

repoPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"
source checkFunctions.sh

# Script arguments handle
__verbose=
__bitbake_cmd=()
__only_shell=
__wifi_settings_interactive=
__debug=
while (( $# )); do
    case ${1,,} in
        -v|--verbose)
            __verbose=1
            echo "Verbose output enabled"
            ;;
        -bc|--bitbake-cmd)
            shift
            __bitbake_cmd+=("${@}")
            echo Custom bitbake command: "${__bitbake_cmd[@]}"
            ;;
        --shell)
            __only_shell=1
            echo "Only shell mode"
            ;;
        -wi|--wifi-interactive)
            __wifi_settings_interactive=1
            ;;
        -d|--debug)
            __debug=":${repoPath}/debug.yml"
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
    kas checkout "${CONF_FILE}"
fi

# Set WIFI configuration
if [ -n "${__wifi_settings_interactive}" ]
then
    read -p "Enter your ssid: " WIFISSID
    read -p "Enter your pass: " WIFIPASS
fi
if [ -n "${WIFISSID}" ] && [ -n "${WIFIPASS}" ]
then
    pushd ./meta-config-pi/recipes-system/network-settings/wifi || return
    sed -i -E "s/ssid=\".*\"/ssid=\"$WIFISSID\"/g" wpa_supplicant.conf
    sed -i -E "s/psk=\".*\"/psk=\"$WIFIPASS\"/g" wpa_supplicant.conf
    popd || return
fi

##NOTE Enable verbose option
if [ -n "${__verbose}" ]
then
    echo '***************************************'
    kas shell "${CONF_FILE}" -c "bitbake-layers show-layers"
    echo '***************************************'
    kas shell "${CONF_FILE}" -c "bitbake -e virtual/kernel | grep '^PV'"
    kas shell "${CONF_FILE}" -c "bitbake -e virtual/kernel | grep '^PN'"
    echo '***************************************'
    kas shell "${CONF_FILE}" -c "bitbake -e" > bb.environment
fi

if [ -n "${__only_shell}" ]
then
    kas shell -E "${CONF_FILE}${__debug}"
    exit 0
fi

###Enable option for only start
if [ -z "${__bitbake_cmd[*]}" ]
then
    time kas build "${CONF_FILE}${__debug}"
else
    echo "Executing command: ${__bitbake_cmd[*]}"
    time kas shell "${CONF_FILE}${__debug}" -c "${__bitbake_cmd[*]}"
fi
