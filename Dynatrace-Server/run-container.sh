#!/bin/bash
NAME=${DT_SERVER_NAME:-"dtserver"}
HOST_NAME=${DT_SERVER_HOST_NAME:-"docker-${NAME}"}
HOST_LOG_DIR=${DT_SERVER_HOST_LOG_DIR:-"/tmp/log/dynatrace/servers/${NAME}"}
LICENSE_KEY_FILE_URL=${DT_SERVER_LICENSE_KEY_FILE_URL}

echo "Creating Dynatrace Server log directory at ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

echo "Starting the Dynatrace Server: ${NAME}"
docker run \
  --name ${NAME} \
  --hostname ${HOST_NAME} \
  --env NAME="${NAME}" \
  --env HOST_NAME="${HOST_NAME}" \
  --env LICENSE_KEY_FILE_URL="${LICENSE_KEY_FILE_URL}" \
  --volume ${HOST_LOG_DIR}:/dynatrace/log/server/${NAME} \
  --publish-all \
  dynatrace/server:6.2