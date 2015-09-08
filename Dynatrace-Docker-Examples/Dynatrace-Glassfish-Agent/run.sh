#!/bin/bash

IMAGE_NAME="dynatrace-glassfish-agent-example"
DT_AGENT_LOG_DIR="/tmp/log/${IMAGE_NAME}"


echo "Creating shared log directory at ${DT_AGENT_LOG_DIR}"
mkdir -p ${DT_AGENT_LOG_DIR}

echo "Starting Glassfish with Dynatrace Agent"
docker run \
  --name ${IMAGE_NAME} \
  --hostname ${IMAGE_NAME} \
  -P \
  -v ${DT_AGENT_LOG_DIR}:/opt/dynatrace/log \
  -d \
  --link dtcollector \
  dynatrace/glassfish-agent-example \
  "$@"

if [ $? -ne 0 ]; then
  echo "Failed to start Glassfish."
  exit 1
fi
