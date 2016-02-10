#!/bin/bash
NAME=${DT_COLLECTOR_NAME:-"dtcollector"}
HOST_NAME=${DT_COLLECTOR_HOST_NAME:-"docker-${NAME}"}
HOST_LOG_DIR=${DT_COLLECTOR_HOST_LOG_DIR:-"/tmp/log/dynatrace/collectors/${NAME}"}
SERVER=${DT_COLLECTOR_SERVER}

# Make sure that the following attributes are set in accordance to the
# Memory Configuration section of the Collector Configuration docs at
# https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration.
JVM_XMS=${DT_COLLECTOR_JVM_XMS:-"2G"}
JVM_XMX=${DT_COLLECTOR_JVM_XMX:-"2G"}
JVM_PERM_SIZE=${DT_COLLECTOR_JVM_PERM_SIZE:-"128m"}
JVM_MAX_PERM_SIZE=${DT_COLLECTOR_JVM_MAX_PERM_SIZE:-"128m"}

echo "Creating Dynatrace Collector log directory at ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

echo "Starting the Dynatrace Collector: ${NAME}"
docker run \
  --name ${NAME} \
  --hostname ${HOST_NAME} \
  --link dtserver \
  --env NAME="${NAME}" \
  --env HOST_NAME="${HOST_NAME}" \
  --env SERVER="${SERVER}" \
  --env JVM_XMS="${JVM_XMS}" \
  --env JVM_XMX="${JVM_XMX}" \
  --env JVM_PERM_SIZE="${JVM_PERM_SIZE}" \
  --env JVM_MAX_PERM_SIZE="${JVM_MAX_PERM_SIZE}" \
  --volume ${HOST_LOG_DIR}:/dynatrace/log/collector/${NAME} \
  --publish-all \
  dynatrace/collector:6.2