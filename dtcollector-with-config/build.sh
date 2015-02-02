#! /bin/bash

DYNATRACE_VERSION=6.1

TAG=${DYNATRACE_VERSION}-`date +%Y%m%d-%H%M%S`

echo "Building Docker image"
sudo docker build -t centic9/dtcollector-with-config:${TAG} .
if [ $? -ne 0 ];then
	echo "Failed to build Docker image"
	exit 1
fi

echo "Pushing image with tag ${TAG} to Docker registry, using dynaTrace version ${DYNATRACE_VERSION}"
sudo docker tag centic9/dtcollector-with-config:${TAG} centic9/dtcollector-with-config:${DYNATRACE_VERSION}-latest
sudo docker tag centic9/dtcollector-with-config:${TAG} centic9/dtcollector-with-config:latest
