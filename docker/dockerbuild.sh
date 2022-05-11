#!/usr/bin/env bash

export reporoot="$(realpath "$(dirname "${BASH_SOURCE[0]}")"/..)"
export DOCKER_IMAGE_NAME="dev-env-yocto"

echo "Building docker"
docker build \
    -t "${DOCKER_IMAGE_NAME}" \
    --build-arg INSIDE_DOCKER=1 \
    "${reporoot}/docker/"
