#!/bin/bash

export uid=$(id -u)
export gid=$(id -g)
export user=$(id -nu)
export group=$(id -ng)

repoPath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source checkFunctions.sh
check_docker

# Check if running under WSL distro
if [ -n "${WSL_DISTRO_NAME}" ]
then
    # Check if docker daemon is running
    is_docker_daemon_running="$(ps -a | grep -c dockerd)"
    if [ "${is_docker_daemon_running}" -lt 1 ]
    then
        echo Docker daemon is not running.
        echo run it with: sudo dockerd
        exit 0
    fi
fi

# Check if current user is in the docker group
is_user_in_docker_group=$(id | grep -c docker)
if [ "$is_user_in_docker_group" -eq 0 ]
then
    echo "The user $user should have in docker group. Try this:"
    echo "sudo usermod -aG docker $user"
    echo "Reboot your system. Then, try it again!"
    exit 1
fi

# Check if docker image was built
image_exits=$(docker images | grep -c dev-env-yocto)
if [ "${image_exits}" -lt 1 ]
then
    echo "Not image dev-env-yocto found. Let's building it!"
    "${repoPath}"/docker/dockerbuild.sh
fi

__wifi_settings=
if [ -n "${WIFISSID}" ] && [ -n "${WIFIPASS}" ]
then
    __wifi_settings+="--env WIFISSID=${WIFISSID}"
    __wifi_settings+="--env WIFIPASS=${WIFIPASS}"
fi

docker run \
    -it --rm \
    --privileged \
    --name devenv \
    --mount type=bind,source="${repoPath}",target=/yocto \
    --env USER="$user" \
    --env UID="$uid" \
    --env GROUP="$group" \
    --env GID="$gid" \
    --env SHELL="/bin/bash" \
    ${__wifi_settings[@]} \
    dev-env-yocto:latest \
    "${@}"

