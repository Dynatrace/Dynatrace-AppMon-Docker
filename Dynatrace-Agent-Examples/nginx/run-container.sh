#!/bin/bash
echo "Starting NGINX - Example"
docker run --rm \
  --name nginx-example \
  --volumes-from dtagent \
  --link dtcollector \
  --link dtagent \
  --env WSAGENT_NAME=nginx-agent \
  --publish-all \
  nginx \
  sh -c "\${DTAGENT_ENV_DT}/run-wsagent.sh && \
         LD_PRELOAD=\${DTAGENT_ENV_LIB64} nginx -g 'daemon off;'"