#!/bin/bash

IMAGE_NAME=dynatrace/collector
IMAGE_TAG=6.2

echo "Building Docker image: ${IMAGE_NAME}:${IMAGE_TAG}"
docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
if [ $? -ne 0 ]; then
	echo "Failed to build image: ${IMAGE_NAME}:${IMAGE_TAG}"
	exit 1
fi 

docker tag -f ${IMAGE_NAME}:${IMAGE_TAG} ${IMAGE_NAME}
