#!/bin/bash
NAME=${NAME:-"dtserver"}

${DT}/dtserver -instance ${NAME} -portoffset 0 -bg
${DT}/dtfrontendserver -instance ${NAME}