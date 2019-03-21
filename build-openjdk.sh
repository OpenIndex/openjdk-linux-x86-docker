#!/usr/bin/env bash
DOCKER_IMAGE="openjdk11-linux-x86"
DOCKER_CONTAINER="build-openjdk11-linux-x86"

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DIR"

DOCKER_IMAGE_ID="$(docker images -q "$DOCKER_IMAGE")"
if [[ -z "$DOCKER_IMAGE_ID" ]]; then
    echo ""
    echo -e "\e[1m\e[92m=================================================\e[0m"
    echo -e "\e[1m\e[92m build docker image\e[0m"
    echo -e "\e[1m\e[92m=================================================\e[0m"
    echo ""
    docker build --tag "$DOCKER_IMAGE" .
fi

echo ""
echo -e "\e[1m\e[92m=================================================\e[0m"
echo -e "\e[1m\e[92m run docker image\e[0m"
echo -e "\e[1m\e[92m=================================================\e[0m"
echo ""
docker run --name "$DOCKER_CONTAINER" "$DOCKER_IMAGE"

echo ""
echo -e "\e[1m\e[92m=================================================\e[0m"
echo -e "\e[1m\e[92m export packages\e[0m"
echo -e "\e[1m\e[92m=================================================\e[0m"
echo ""
rm -Rf package
DOCKER_CONTAINER_ID="$(docker ps -aqf "name=$DOCKER_CONTAINER")"
docker cp "$DOCKER_CONTAINER_ID":/openjdk-linux-x86/package .

echo ""
echo -e "\e[1m\e[92m=================================================\e[0m"
echo -e "\e[1m\e[92m remove docker container\e[0m"
echo -e "\e[1m\e[92m=================================================\e[0m"
echo ""
docker container rm -f "$DOCKER_CONTAINER_ID"
