#!/bin/bash
DT_COLLECTOR_NAME=${DT_COLLECTOR_NAME:-"dtcollector"}
DT_COLLECTOR_HOST_NAME=${DT_COLLECTOR_HOST_NAME:-"docker-${DT_COLLECTOR_NAME}"}
DT_COLLECTOR_HOST_LOG_DIR=${DT_COLLECTOR_HOST_LOG_DIR:-"/tmp/log/dynatrace/collectors/${DT_COLLECTOR_NAME}"}
DT_COLLECTOR_SERVER=${DT_COLLECTOR_SERVER}

# Make sure that the following attributes are set in accordance to the
# Memory Configuration section of the Collector Configuration docs at
# https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration.
DT_COLLECTOR_JVM_XMS=${DT_COLLECTOR_JVM_XMS:-"2G"}
DT_COLLECTOR_JVM_XMX=${DT_COLLECTOR_JVM_XMX:-"2G"}
DT_COLLECTOR_JVM_PERM_SIZE=${DT_COLLECTOR_JVM_PERM_SIZE:-"128m"}
DT_COLLECTOR_JVM_MAX_PERM_SIZE=${DT_COLLECTOR_JVM_MAX_PERM_SIZE:-"128m"}

echo "Creating Dynatrace Collector log directory at ${DT_COLLECTOR_HOST_LOG_DIR}"
mkdir -p ${DT_COLLECTOR_HOST_LOG_DIR}

echo "Starting the Dynatrace Collector: ${DT_COLLECTOR_NAME}"
docker run \
  --name ${DT_COLLECTOR_NAME} \
  --hostname ${DT_COLLECTOR_HOST_NAME} \
  --link dtserver \
  --env DT_COLLECTOR_NAME="${DT_COLLECTOR_NAME}" \
  --env DT_COLLECTOR_HOST_NAME="${DT_COLLECTOR_HOST_NAME}" \
  --env DT_COLLECTOR_SERVER="${DT_COLLECTOR_SERVER}" \
  --env DT_COLLECTOR_JVM_XMS="${DT_COLLECTOR_JVM_XMS}" \
  --env DT_COLLECTOR_JVM_XMX="${DT_COLLECTOR_JVM_XMX}" \
  --env DT_COLLECTOR_JVM_PERM_SIZE="${DT_COLLECTOR_JVM_PERM_SIZE}" \
  --env DT_COLLECTOR_JVM_MAX_PERM_SIZE="${DT_COLLECTOR_JVM_MAX_PERM_SIZE}" \
  --volume ${DT_COLLECTOR_HOST_LOG_DIR}:/opt/dynatrace/log/collector/${DT_COLLECTOR_NAME} \
  --publish-all \
  dynatrace/collector