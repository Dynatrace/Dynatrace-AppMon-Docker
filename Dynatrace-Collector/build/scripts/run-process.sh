#!/bin/bash
NAME=${DT_COLLECTOR_NAME:-"dtcollector"}
GROUP_NAME=${DT_COLLECTOR_GROUP_NAME}

JVM_XMS=${DT_COLLECTOR_JVM_XMS:-"2G"}
JVM_XMX=${DT_COLLECTOR_JVM_XMX:-"2G"}
JVM_PERM_SIZE=${DT_COLLECTOR_JVM_PERM_SIZE:-"128m"}
JVM_MAX_PERM_SIZE=${DT_COLLECTOR_JVM_MAX_PERM_SIZE:-"128m"}

# We attempt to auto-discover the Dynatrace Server through the environment
# when the container has been --linked to a 'dynatrace/server' container
# instance with a link alias 'dtserver'.
#
# Example: docker run --link dtserver-1:dtserver dynatrace/collector
#
# Auto-discovery can be overridden by providing the $SERVER variable
# through the environment.
SERVER_HOST_NAME=${DTSERVER_ENV_HOST_NAME:-"docker-dtserver"}
SERVER_COLLECTOR_PORT=${DTSERVER_ENV_COLLECTOR_PORT:-"6698"}
SERVER=${DT_COLLECTOR_SERVER:-"${SERVER_HOST_NAME}:${SERVER_COLLECTOR_PORT}"}

# Wait for the server to start serving collectors.
wait-for-cmd.sh "nc -z `echo ${SERVER} | sed 's/:/ /'`" 360

${DT}/dtcollector -instance ${NAME} \
                  -listen ${AGENT_PORT} \
                  -server ${SERVER} \
                  -group ${GROUP_NAME} \
                  -Xms${JVM_XMS} \
                  -Xmx${JVM_XMX} \
                  -XX:PermSize=${JVM_PERM_SIZE} \
                  -XX:MaxPermSize=${JVM_MAX_PERM_SIZE}