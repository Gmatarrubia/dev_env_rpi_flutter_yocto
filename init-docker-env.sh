#!/bin/bash

export uid=$(id -u)
export gid=$(id -g)
export user=$(id -nu)
export group=$(id -ng)

repoPath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

source checkFunctions.sh
check_docker
if [ $? -eq 1 ]
then
    exit 1
fi

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
    --ipc=host \
    --network=host \
    --publish-all \
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

