#!/bin/bash
DT_SERVER_NAME=${DT_SERVER_NAME:-"dtserver"}

${DT_SERVER_HOME}/dtserver -instance ${DT_SERVER_NAME} -portoffset 0 -bg
${DT_SERVER_HOME}/dtfrontendserver -instance ${DT_SERVER_NAME}