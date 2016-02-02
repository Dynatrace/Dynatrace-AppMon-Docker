#!/bin/bash
NAME=${DT_WSAGENT_NAME:-"dtwsagent"}
HOST_NAME=${DT_WSAGENT_HOST_NAME:-"docker-${NAME}"}
HOST_LOG_DIR=${DT_WSAGENT_HOST_LOG_DIR:-"/tmp/log/dynatrace/wsagents/${NAME}"}
LOG_LEVEL=${DT_WSAGENT_LOG_LEVEL:-"info"}
COLLECTOR=${DT_WSAGENT_COLLECTOR}

echo "Creating Dynatrace Web Server Agent log directory at ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

echo "Starting the Dynatrace Web Server Agent: ${NAME}"
docker run \
  --name ${NAME} \
  --hostname ${HOST_NAME} \
  --link dtcollector \
  --env NAME="${NAME}" \
  --env HOST_NAME="${HOST_NAME}" \
  --env LOG_LEVEL="${LOG_LEVEL}" \
  --env COLLECTOR="${COLLECTOR}" \
  --volume /opt/dynatrace \
  --volume ${HOST_LOG_DIR}:/opt/dynatrace/log \
  --publish-all \
  dynatrace/wsagent