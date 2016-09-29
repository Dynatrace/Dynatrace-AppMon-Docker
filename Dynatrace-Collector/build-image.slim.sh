#!/bin/bash
DOCKER_FILE=Dockerfile.slim
DOCKER_IMAGE_NAME=dynatrace/collector
DOCKER_IMAGE_TAG=6.5-slim

echo "Building Docker image: ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} -f ${DOCKER_FILE} .
if [ $? -ne 0 ]; then
  echo "Failed to build image: ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
  exit 1
fi 

docker tag ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ${DOCKER_IMAGE_NAME}:slim