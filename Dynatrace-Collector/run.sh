#!/bin/bash

DT_COLLECTOR_NAME="dtcollector"
DT_COLLECTOR_LOG_DIR="/tmp/log/${DT_COLLECTOR_NAME}"

DT_COLLECTOR_SERVER="localhost:6698"
DT_COLLECTOR_AGENT_PORT="9998"
DT_COLLECTOR_LOCAL_AGENT_PORT=$DT_COLLECTOR_AGENT_PORT

# Make sure that the following attributes are set in accordance to the
# Memory Configuration section of the Collector Configuration docs at
# https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration.
DT_COLLECTOR_JVM_XMS="2G"
DT_COLLECTOR_JVM_XMX="2G"
DT_COLLECTOR_JVM_PERM_SIZE="128m"
DT_COLLECTOR_JVM_MAX_PERM_SIZE="128m"


echo "Creating shared log directory at ${DT_COLLECTOR_LOG_DIR}"
mkdir -p ${DT_COLLECTOR_LOG_DIR}

echo "Starting the Dynatrace Collector with Agent connections on port ${DT_COLLECTOR_AGENT_PORT}"
docker run \
  --name=${DT_COLLECTOR_NAME} \
  --hostname=${DT_COLLECTOR_NAME} \
  -p localhost:${DT_COLLECTOR_LOCAL_AGENT_PORT}:${DT_COLLECTOR_AGENT_PORT} \
  -v ${DT_COLLECTOR_LOG_DIR}:/opt/dynatrace/log/collector/${DT_COLLECTOR_NAME} \
  -d \
  dynatrace/collector \
  -instance ${DT_COLLECTOR_NAME} \
  -listen ${DT_COLLECTOR_AGENT_PORT} \
  -server ${DT_COLLECTOR_SERVER} \
  -Xms${DT_COLLECTOR_JVM_XMS} \
  -Xmx${DT_COLLECTOR_JVM_XMX} \
  -XX:PermSize=${DT_COLLECTOR_JVM_PERM_SIZE} \
  -XX:MaxPermSize=${DT_COLLECTOR_JVM_MAX_PERM_SIZE} \
  "$@"

if [ $? -ne 0 ]; then
	echo "Failed to start the Dynatrace Collector."
	exit 1
fi
