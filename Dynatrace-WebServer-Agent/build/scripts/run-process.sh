#!/bin/bash
NAME=${NAME:-"dtwsagent"}
LOG_LEVEL=${LOG_LEVEL:-"info"}

# We attempt to auto-discover the Dynatrace Collector through the environment
# when the container has been --linked to a 'dynatrace/collector' container
# instance with a link alias 'dtcollector'.
#
# Example: docker run --link dtcollector-1:dtcollector dynatrace/wsagent
#
# Auto-discovery can be overridden by providing the $COLLECTOR variable
# through the environment.
COLLECTOR_HOST_NAME=${DTCOLLECTOR_ENV_HOST_NAME:-"docker-dtcollector"}
COLLECTOR_PORT=${DTCOLLECTOR_ENV_AGENT_PORT:-"9998"}
COLLECTOR=${COLLECTOR:-"${COLLECTOR_HOST_NAME}:${COLLECTOR_PORT}"}

# Wait for the collector to start serving agents.
wait-for-cmd.sh "nc -z `echo ${COLLECTOR} | sed 's/:/ /'`" 360

# Assert that incoming slave agents are accepted only after dtwsagent has started.
(wait-for-cmd.sh "nc -uz 127.0.0.1 ${SLAVE_AGENT_PORT}" 60 && sleep 1 && ${DT}/accept-wsagent-slaves.sh) &

sed -i -r "s/^#?Name dtwsagent/Name ${NAME}/;s/^#?Server localhost/Server ${COLLECTOR}/;s/^#?Loglevel info/Loglevel ${LOG_LEVEL}/" ${INI} && \
${BIN64}