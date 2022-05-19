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
        code --install-extension Dart-Code.dart-code Dart-Code.flutter mhutchie.git-graph ms-vscode-remote.remote-containers ms-vscode-remote.remote-wsl
        code --install-extension ms-vscode-remote.vscode-remote-extensionpack timonwong.shellcheck
    fi
}
function check_kas(){
    # Check kas command
    if [ -n "$(which kas)" ]
    then
        pip install kas
    else
        echo "Kas has already installed"
    fi
}