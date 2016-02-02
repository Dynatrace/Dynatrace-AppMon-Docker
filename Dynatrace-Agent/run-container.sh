#!/bin/bash
NAME=${DT_AGENT_NAME:-"dtagent"}
HOST_LOG_DIR=${DT_AGENT_HOST_LOG_DIR:-"/tmp/log/dynatrace/agents/${NAME}"}

echo "Creating Dynatrace Agent log directory at ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

echo "Starting the Dynatrace Agent: ${NAME}"
docker run \
  --name ${NAME} \
  --volume /opt/dynatrace \
  --volume ${HOST_LOG_DIR}:/opt/dynatrace/log/agent \
  dynatrace/agent