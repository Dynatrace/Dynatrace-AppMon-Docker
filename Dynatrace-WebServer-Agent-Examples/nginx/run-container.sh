#!/bin/bash
echo "Starting NGINX - Example"
docker run --rm \
  --name nginx-example \
  --link dtwsagent \
  --volumes-from dtwsagent \
  --ipc container:dtwsagent \
  --publish-all \
  nginx \
  sh -c "(sleep 1 && \${DTWSAGENT_ENV_DT_WSAGENT_HOME}/attach-wsagent-slave.sh &) && \
         LD_PRELOAD=\${DTWSAGENT_ENV_DT_WSAGENT_LIB64} nginx"