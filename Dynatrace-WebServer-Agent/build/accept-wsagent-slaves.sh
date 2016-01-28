#!/bin/bash

# socat forwards incoming slaves to the loopback network interface.
${SOCAT_HOME}/socat udp4-listen:${DT_WSAGENT_SLAVE_AGENT_PORT},fork udp:localhost:${DT_WSAGENT_SLAVE_AGENT_PORT}