#!/bin/bash

set -e
currentPath="$(dirname $(realpath ${BASH_SOURCE[0]}))"

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

function check_googleRepoTool(){
    repoToolDir="$currentPath/repoTool"
    repoToolBinary="$repoToolDir/repo"
    PATH="$repoToolDir:${PATH}"
    if [ ! -f "$repoToolDir" ]
    then
        mkdir -p "$repoToolDir"
    	curl https://storage.googleapis.com/git-repo-downloads/repo > "$repoToolBinary"
    	chmod a+rx "$repoToolBinary"
    fi
}

## Script entry
check_vscode
check_ansible
check_googleRepoTool

sudo ansible-playbook installDevEnv.yml
ansible-playbook installYocto.yml
