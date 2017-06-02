#!/bin/bash
AGENT_NAME=${DT_AGENT_NAME:-"dtagent"}
LOG_LEVEL=${DT_AGENT_LOG_LEVEL:-"info"}

# Attempt to auto-discover the Dynatrace Collector through the environment when
# the container has been --linked to a 'dynatrace/collector' container instance
# with a link alias 'dtcollector'.
#
# Example: docker run --link dtcollector-1:dtcollector httpd
#
# Auto-discovery can be overridden by providing the $COLLECTOR variable through
# the environment.
COLLECTOR_HOST_NAME=${DT_COLLECTOR_NAME:-"dtcollector"}
COLLECTOR_PORT=${APPMON_COLLECTOR_PORT:-"9998"}
COLLECTOR=${DT_AGENT_COLLECTOR:-"${COLLECTOR_HOST_NAME}:${COLLECTOR_PORT}"}

# Attempt to auto-discover the Dynatrace Web Server Agent binary through
# the environment when the container has been --linked to a 'dynatrace/agent'
# container instance with a link alias 'dtagent'.
#
# Example: docker run --link dtagent-1:dtagent httpd
#
# Auto-discovery can be overridden by providing the $WSAGENT_BIN variable
# through the environment, or as the first argument to this script.
WSAGENT_BIN=${1:-"${DTAGENT_ENV_WSAGENT_BIN64}"}
if [ -z ${WSAGENT_BIN} ]; then
  WSAGENT_BIN=${DT_HOME}/agent/lib64/dtwsagent
fi

# Attempt to auto-discover the Dynatrace Web Server Agent configuration through
# the environment when the container has been --linked to a 'dynatrace/agent'
# container instance with a link alias 'dtagent'.
#
# Example: docker run --link dtagent-1:dtagent httpd
#
# Auto-discovery can be overridden by providing the $WSAGENT_INI variable
# through the environment, or as the second argument to this script.
WSAGENT_INI=${2:-"${DTAGENT_ENV_WSAGENT_INI}"}
if [ -z ${WSAGENT_INI} ]; then
  WSAGENT_INI=${DT_HOME}/agent/conf/dtwsagent.ini
fi

sed -i -r "s/^#?Name.*/Name ${AGENT_NAME}/;s/^#?Server.*/Server ${COLLECTOR}/;s/^#?Loglevel.*/Loglevel ${LOG_LEVEL}/;s/^#?ConsoleLoglevel.*/ConsoleLoglevel ${LOG_LEVEL}/" ${WSAGENT_INI}

${WSAGENT_BIN} &
