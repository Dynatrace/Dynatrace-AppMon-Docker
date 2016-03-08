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
COLLECTOR_HOST_NAME=${DTCOLLECTOR_ENV_HOST_NAME:-"docker-dtcollector"}
COLLECTOR_PORT=${DTCOLLECTOR_ENV_AGENT_PORT:-"9998"}
COLLECTOR=${DT_AGENT_COLLECTOR:-"${COLLECTOR_HOST_NAME}:${COLLECTOR_PORT}"}

# Attempt to auto-discover the Dynatrace Web Server Agent binary through
# the environment when the container has been --linked to a 'dynatrace/agent'
# container instance with a link alias 'dtagent'.
#
# Example: docker run --link dtagent-1:dtagent httpd
#
# Auto-discovery can be overridden by providing the $BIN variable through
# the environment, or as the first argument to this script.
BIN=${1:-"${DTAGENT_ENV_BIN64}"}
if [ -z ${BIN} ]; then
  BIN=/dynatrace/agent/lib64/dtwsagent
fi

# Attempt to auto-discover the Dynatrace Web Server Agent configuration through
# the environment when the container has been --linked to a 'dynatrace/agent'
# container instance with a link alias 'dtagent'.
#
# Example: docker run --link dtagent-1:dtagent httpd
#
# Auto-discovery can be overridden by providing the $INI variable through
# the environment, or as the second argument to this script.
INI=${2:-"${DTAGENT_ENV_INI}"}
if [ -z ${INI} ]; then
  INI=/dynatrace/agent/conf/dtwsagent.ini
fi

sed -i -r "s/^#?Name.*/Name ${AGENT_NAME}/;s/^#?Server.*/Server ${COLLECTOR}/;s/^#?Loglevel.*/Loglevel ${LOG_LEVEL}/;s/^#?ConsoleLoglevel.*/ConsoleLoglevel ${LOG_LEVEL}/" ${INI}

${BIN} &