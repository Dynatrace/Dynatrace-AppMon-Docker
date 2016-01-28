#!/bin/bash
DT_SERVER_NAME=${DT_SERVER_NAME:-"dtserver"}
DT_SERVER_HOST_NAME=${DT_SERVER_HOST_NAME:-"docker-${DT_SERVER_NAME}"}
DT_SERVER_HOST_LOG_DIR=${DT_SERVER_HOST_LOG_DIR:-"/tmp/log/dynatrace/servers/${DT_SERVER_NAME}"}
DT_SERVER_LICENSE_KEY_FILE_URL=${DT_SERVER_LICENSE_KEY_FILE_URL}

echo "Creating Dynatrace Server log directory at ${DT_SERVER_HOST_LOG_DIR}"
mkdir -p ${DT_SERVER_HOST_LOG_DIR}

echo "Starting the Dynatrace Server: ${DT_SERVER_NAME}"
docker run \
  --name ${DT_SERVER_NAME} \
  --hostname ${DT_SERVER_HOST_NAME} \
  --env DT_SERVER_NAME="${DT_SERVER_NAME}" \
  --env DT_SERVER_HOST_NAME="${DT_SERVER_HOST_NAME}" \
  --env DT_SERVER_LICENSE_KEY_FILE_URL="${DT_SERVER_LICENSE_KEY_FILE_URL}" \
  --volume ${DT_SERVER_HOST_LOG_DIR}:/opt/dynatrace/log/server/${DT_SERVER_NAME} \
  --publish-all \
  dynatrace/server
