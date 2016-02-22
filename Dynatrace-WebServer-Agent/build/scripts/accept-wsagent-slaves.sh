#!/bin/bash

# socat forwards incoming slaves to the loopback network interface.
${DT}/socat udp4-listen:${SLAVE_AGENT_PORT},fork udp:localhost:${SLAVE_AGENT_PORT}