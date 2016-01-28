#!/bin/bash
DT_WSAGENT_NAME=${DT_WSAGENT_NAME:-"dtwsagent"}
DT_WSAGENT_HOST_NAME=${DT_WSAGENT_HOST_NAME:-"docker-${DT_WSAGENT_NAME}"}
DT_WSAGENT_HOST_LOG_DIR=${DT_WSAGENT_HOST_LOG_DIR:-"/tmp/log/dynatrace/wsagents/${DT_WSAGENT_NAME}"}
DT_WSAGENT_LOG_LEVEL=${DT_WSAGENT_LOG_LEVEL:-"info"}
DT_WSAGENT_COLLECTOR=${DT_WSAGENT_COLLECTOR}

echo "Creating Dynatrace WebServer Agent log directory at ${DT_WSAGENT_HOST_LOG_DIR}"
mkdir -p ${DT_WSAGENT_HOST_LOG_DIR}

echo "Starting the Dynatrace WebServer Agent: ${DT_WSAGENT_NAME}"
docker run \
  --name ${DT_WSAGENT_NAME} \
  --hostname ${DT_WSAGENT_HOST_NAME} \
  --link dtcollector \
  --env DT_WSAGENT_NAME="${DT_WSAGENT_NAME}" \
  --env DT_WSAGENT_HOST_NAME="${DT_WSAGENT_HOST_NAME}" \
  --env DT_WSAGENT_LOG_LEVEL="${DT_WSAGENT_LOG_LEVEL}" \
  --env DT_WSAGENT_COLLECTOR="${DT_WSAGENT_COLLECTOR}" \
  --volume /opt/dynatrace \
  --volume ${DT_WSAGENT_HOST_LOG_DIR}:/opt/dynatrace/log \
  --publish-all \
  dynatrace/wsagent