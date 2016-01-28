#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTWSAGENT_ENV_DT_WSAGENT_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  --link dtwsagent \
  --volumes-from dtwsagent \
  --ipc container:dtwsagent \
  --publish-all \
  httpd \
  sh -c "(sleep 1 && \${DTWSAGENT_ENV_SOCAT_HOME}/attach-to-wsagent-master.sh &) && \
         (echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf) && \
         httpd-foreground"