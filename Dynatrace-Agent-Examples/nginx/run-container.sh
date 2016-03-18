#!/bin/bash
echo "Starting NGINX - Example"
docker run --rm \
  --name nginx-example \
  --env DT_AGENT_NAME=nginx-agent \
  --volumes-from dtagent \
  --link dtagent \
  --link dtcollector \
  --publish-all \
  nginx \
  sh -c "\${DTAGENT_ENV_DT}/run-wsagent.sh && \
         LD_PRELOAD=\${DTAGENT_ENV_AGENT_LIB64} nginx -g 'daemon off;'"