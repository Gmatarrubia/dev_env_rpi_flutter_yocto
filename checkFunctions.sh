#!/bin/bash

# This file is intended to be sourced, not run directly
if [ -n "$BASH_SOURCE" ]; then
    THIS_SCRIPT=$BASH_SOURCE
fi
if [ "$0" = "$THIS_SCRIPT" ]; then
    echo "Error: This script needs to be sourced. Please run as '. $THIS_SCRIPT'" >&2
    exit 1
fi

function check_ansible(){
    if [ -n "$(which ansible-playbook)" ]
    then
        echo "Ansible already installed"
    else
        echo "Installing ansible..."
        sudo apt install -y ansible
    fi
}

function check_vscode(){
    if [ -n "$(which code)" ]
    then
        echo "VS Code already installed"
    else
        echo "Installing vscode..."
        wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
        sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
        sudo apt install -y code
        code --install-extension mhutchie.git-graph
        code --install-extension ms-vscode-remote.vscode-remote-extensionpack
        code --install-extension timonwong.shellcheck
        code --install-extension moshfeu.compare-folders
        code --install-extension ms-python.python
        code --install-extension ms-azuretools.vscode-docker
        code --install-extension EugenWiens.bitbake
    fi
}
function check_kas(){
    # Check kas command
    if [ -n "$(which kas)" ]
    then
        echo "Kas has already installed"
    else
        pip install kas
    fi
}

function check_docker(){
    if [ -n "$(which docker)" ]
    then
        echo "Docker already installed"
    else
        sudo apt install -y curl
        curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
        sudo sh /tmp/get-docker.sh
    fi
}

# Print help
function print_help(){
    echo "This script help you with the initial configuration and with the build process."
    echo "you can use this script with these options:"
    echo " "
    echo "-v | --verbose) Prints more detailled output."
    echo " "
    echo "-bc | --bitbake-cmd) Performs your custom bitbake/devtool command."
    echo "    some examples of this:"
    echo "    ./build.sh --bitbake-cmd bitbake -e > output.sh"
    echo "    ./build.sh -bc bitbake-getvar core-image-minimal"
    echo " "
    echo "--shell) Opens a bitbake shell without do anything else."
    echo " "
    echo "-h | --help) Prints this useful help :)"
}