#!/bin/bash

export uid=$(id -u)
export gid=$(id -g)
export user=$(id -nu)
export group=$(id -ng)

repoPath="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

# Check if current user is in the docker group
is_user_in_docker_group=$(id | grep -c docker)
if [ "$is_user_in_docker_group" -eq 0 ]
then
    echo "The user $user should have in docker group. Try this:"
    echo "sudo usermod -aG docker $user"
    exit 1
fi

# Check if docker image was built
image_exits=$(docker images | grep -c dev-env-yocto)
if [ "${image_exits}" -lt 1 ]
then
    echo "Not image dev-env-yocto found. Let's building it!"
    "${repoPath}"/docker/dockerbuild.sh
fi

docker run \
    -it --rm \
    --privileged \
    --name devenv \
    --volume "${repoPath}":/yocto \
    --env USER="$user" \
    --env UID="$uid" \
    --env GROUP="$group" \
    --env GID="$gid" \
    --env SHELL="/bin/bash"
    dev-env-yocto:latest \
    "${@}"

