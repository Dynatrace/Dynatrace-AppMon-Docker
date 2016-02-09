#!/bin/bash
DT=`find / -name dynatrace`

# We attempt to auto-discover the Dynatrace Web Server (master agent) through
# the environment when the container has been --linked to a 'dynatrace/wsagent'
# container instance with a link alias 'dtwsagent'.
#
# Example: docker run --link dtwsagent-1:dtwsagent httpd
#
# Auto-discovery can be overridden by providing the $WSAGENT variable
# through the environment.
WSAGENT_SLAVE_AGENT_PORT=`grep -E '^#?Port ' ${DT}/agent/conf/dtwsagent.ini | cut -d' ' -f2`

WSAGENT_HOST_NAME=${DTWSAGENT_ENV_HOST_NAME:-"docker-dtwsagent"}
WSAGENT_SLAVE_AGENT_PORT=${DTWSAGENT_ENV_SLAVE_AGENT_PORT:-"${WSAGENT_SLAVE_AGENT_PORT}"}
WSAGENT=${WSAGENT:-"${WSAGENT_HOST_NAME}:${WSAGENT_SLAVE_AGENT_PORT}"}

# socat forwards incoming slaves to the dtwsagent's host.
${DT}/socat udp-listen:`echo ${WSAGENT} | cut -d':' -f2`,fork udp:${WSAGENT}