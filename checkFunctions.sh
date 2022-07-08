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
    fi

    list_of_extensions=(
        mhutchie.git-graph
        ms-vscode-remote.vscode-remote-extensionpack
        timonwong.shellcheck
        moshfeu.compare-folders
        ms-python.python
        ms-azuretools.vscode-docker
        EugenWiens.bitbake
        rogalmic.bash-debug

    )

    # Install missing extensions
    for ext in "${list_of_extensions[@]}"
    do
        if [ "$(code --list-extensions | grep -c "${ext}")" -eq 0 ]
        then
            echo "Installing extension: ${ext}"
            code --install-extension "${ext}"
        fi
    done
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
    local user=$(id -nu)
    if [ -n "$(which docker)" ]
    then
        echo "Docker already installed"
    else
        echo "Installing docker..."
        sudo apt install -y curl
        curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
        sudo sh /tmp/get-docker.sh > /dev/null
    fi
    # Check if current user is in the docker group
    is_user_in_docker_group=$(id | grep -c docker)
    if [ "$is_user_in_docker_group" -eq 1 ]
    then
        echo "User already added to docker group"
    else
        echo "Adding user $user to docker group."
        echo "Sudo password needed."
        sudo usermod -aG docker "$user"
        echo "Reboot your system. Then, try it again!"
        return 1
    fi
    return 0
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
    echo "-wi | --wifi-interactive) For setting Wi-Fi settings."
    echo " "
    echo "-d | --debug) Enables debug features on the local.conf"
    echo " "
    echo "-h | --help) Prints this useful help :)"
}