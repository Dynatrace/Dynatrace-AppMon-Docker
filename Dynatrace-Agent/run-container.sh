#!/bin/bash
DT_AGENT_NAME=${DT_AGENT_NAME:-"dtagent"}
DT_AGENT_HOST_LOG_DIR=${DT_AGENT_HOST_LOG_DIR:-"/tmp/log/dynatrace/agents/${DT_AGENT_NAME}"}

echo "Creating Dynatrace Agent log directory at ${DT_AGENT_HOST_LOG_DIR}"
mkdir -p ${DT_AGENT_HOST_LOG_DIR}

echo "Starting the Dynatrace Agent: ${DT_AGENT_NAME}"
docker run \
  --name ${DT_AGENT_NAME} \
  --volume /opt/dynatrace \
  --volume ${DT_AGENT_HOST_LOG_DIR}:/opt/dynatrace/log/agent \
  dynatrace/agent