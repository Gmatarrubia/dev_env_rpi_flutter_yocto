#!/usr/bin/bash

export reporoot="$(realpath "$(dirname "${BASH_SOURCE[0]}")"/..)"
export DOCKER_IMAGE_NAME="dev-env-yocto"
export uid=$(id -u)
export gid=$(id -g)
export user=$(id -nu)
export group=$(id -ng)

echo "Building docker"
docker build \
    -t "${DOCKER_IMAGE_NAME}" \
    --build-arg INSIDE_DOCKER=1 \
    --build-arg USER="$user" \
    --build-arg UID="$uid" \
    --build-arg GROUP="$group" \
    --build-arg GID="$gid" \
    "${reporoot}/docker/"
