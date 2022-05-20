#!/bin/bash

set -e
currentPath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source ./checkFunctions.sh

## Script entry
if [ -z "${INSIDE_DOCKER}" ]
then
    echo "Not needed vscode inside docker. Skiping!"
    check_vscode
fi
check_ansible

sudo ansible-playbook installDevEnv.yml
