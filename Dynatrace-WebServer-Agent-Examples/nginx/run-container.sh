#!/bin/bash
echo "Starting NGINX - Example"
docker run --rm \
  --name nginx-example \
  --volumes-from dtwsagent \
  --link dtcollector \
  --link dtwsagent \
  --env AGENT_NAME=nginx-agent \
  --publish-all \
  nginx \
  sh -c "\${DTWSAGENT_ENV_DT}/run-wsagent-master.sh && \
         LD_PRELOAD=\${DTWSAGENT_ENV_LIB64} nginx -g 'daemon off;'"