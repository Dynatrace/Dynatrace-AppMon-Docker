#!/bin/bash
NAME=${DT_WSAGENT_NAME:-"dtwsagent"}
HOST_LOG_DIR=${DT_WSAGENT_HOST_LOG_DIR:-"/tmp/log/dynatrace/wsagents/${NAME}"}

echo "Creating Dynatrace Web Server Agent log directory at ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

echo "Starting the Dynatrace Web Server Agent: ${NAME}"
docker run \
  --name ${NAME} \
  --volume /dynatrace \
  --volume ${HOST_LOG_DIR}:/dynatrace/log \
  dynatrace/wsagent:6.2