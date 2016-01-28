#!/bin/bash
DT_COLLECTOR_NAME=${DT_COLLECTOR_NAME:-"dtcollector"}
DT_COLLECTOR_AGENT_PORT=${DT_COLLECTOR_AGENT_PORT:-"9998"}

# We attempt to auto-discover the Dynatrace Server through the environment
# when the container has been --linked to a 'dynatrace/server' container
# instance with a link alias 'dtserver'.
#
# Example: docker run --link dtserver-1:dtserver dynatrace/collector
#
# Auto-discovery can be overridden by providing the $DT_COLLECTOR_SERVER
# variable through the environment.
DT_COLLECTOR_SERVER_HOST_NAME=${DTSERVER_ENV_DT_SERVER_HOST_NAME:-"docker-dtserver"}
DT_COLLECTOR_SERVER_COLLECTOR_PORT=${DTSERVER_ENV_DT_SERVER_COLLECTOR_PORT:-"6698"}
DT_COLLECTOR_SERVER=${DT_COLLECTOR_SERVER:-"${DT_COLLECTOR_SERVER_HOST_NAME}:${DT_COLLECTOR_SERVER_COLLECTOR_PORT}"}

# Wait for the server to start serving collectors.
wait-for-cmd.sh "nc -z ${DT_COLLECTOR_SERVER_HOST_NAME} ${DT_COLLECTOR_SERVER_COLLECTOR_PORT}" 360

DT_COLLECTOR_JVM_XMS=${DT_COLLECTOR_JVM_XMS:-"2G"}
DT_COLLECTOR_JVM_XMX=${DT_COLLECTOR_JVM_XMX:-"2G"}
DT_COLLECTOR_JVM_PERM_SIZE=${DT_COLLECTOR_JVM_PERM_SIZE:-"128m"}
DT_COLLECTOR_JVM_MAX_PERM_SIZE=${DT_COLLECTOR_JVM_MAX_PERM_SIZE:-"128m"}

${DT_COLLECTOR_HOME}/dtcollector -instance ${DT_COLLECTOR_NAME} \
                                 -listen ${DT_COLLECTOR_AGENT_PORT} \
                                 -server ${DT_COLLECTOR_SERVER} \
                                 -Xms${DT_COLLECTOR_JVM_XMS} \
                                 -Xmx${DT_COLLECTOR_JVM_XMX} \
                                 -XX:PermSize=${DT_COLLECTOR_JVM_PERM_SIZE} \
                                 -XX:MaxPermSize=${DT_COLLECTOR_JVM_MAX_PERM_SIZE}