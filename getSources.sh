#!/bin/bash

set -e
currentPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

source ./checkFunctions.sh

## Script entry
check_vscode
check_ansible
check_googleRepoTool

ansible-playbook installYocto.yml
