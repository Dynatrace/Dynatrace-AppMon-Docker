#!/bin/bash

IMAGE_NAME="dynatrace-tomcat-agent-example"
DT_AGENT_LOG_DIR="/tmp/log/${IMAGE_NAME}"


echo "Creating shared log directory at ${DT_AGENT_LOG_DIR}"
mkdir -p ${DT_AGENT_LOG_DIR}

echo "Starting an Apache Tomcat with Dynatrace Agent"
docker run \
  --name ${IMAGE_NAME} \
  --hostname ${IMAGE_NAME} \
  -P \
  -v ${DT_AGENT_LOG_DIR}:/opt/dynatrace/log \
  -d \
  --link dtcollector \
  dynatrace/tomcat-agent-example \
  "$@"

if [ $? -ne 0 ]; then
	echo "Failed to start Apache Tomcat."
	exit 1
fi
