#!/bin/bash
DT_WSAGENT_NAME=${DT_WSAGENT_NAME:-"dtwsagent"}
DT_WSAGENT_LOG_LEVEL=${DT_WSAGENT_LOG_LEVEL:-"info"}

# We attempt to auto-discover the Dynatrace Collector through the environment
# when the container has been --linked to a 'dynatrace/collector' container
# instance with a link alias 'dtcollector'.
#
# Example: docker run --link dtcollector-1:dtcollector dynatrace/wsagent
#
# Auto-discovery can be overridden by providing the $DT_COLLECTOR_COLLECTOR
# variable through the environment.
DT_WSAGENT_COLLECTOR_HOST_NAME=${DTCOLLECTOR_ENV_DT_COLLECTOR_HOST_NAME:-"docker-dtcollector"}
DT_WSAGENT_COLLECTOR_PORT=${DTCOLLECTOR_ENV_DT_COLLECTOR_AGENT_PORT:-"9998"}
DT_WSAGENT_COLLECTOR=${DT_WSAGENT_COLLECTOR:-"${DT_WSAGENT_COLLECTOR_HOST_NAME}:${DT_WSAGENT_COLLECTOR_PORT}"}

# Wait for the collector to start serving agents.
wait-for-cmd.sh "nc -z ${DT_WSAGENT_COLLECTOR_HOST_NAME} ${DT_WSAGENT_COLLECTOR_PORT}" 360

# Assert that incoming slave agents are accepted only after dtwsagent has started.
(wait-for-cmd.sh "nc -uz 127.0.0.1 ${DT_WSAGENT_SLAVE_AGENT_PORT}" 60 && ${SOCAT_HOME}/accept-wsagent-slaves.sh) &

sed -i -r "s/^#?Name dtwsagent/Name ${DT_WSAGENT_NAME}/;s/^#?Server localhost/Server ${DT_WSAGENT_COLLECTOR}/;s/^#?Loglevel info/Loglevel ${DT_WSAGENT_LOG_LEVEL}/" ${DT_WSAGENT_INI} && \
${DT_WSAGENT_BIN64}