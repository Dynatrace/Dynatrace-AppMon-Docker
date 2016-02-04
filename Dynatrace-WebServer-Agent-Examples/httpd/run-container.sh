#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTWSAGENT_ENV_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  --volumes-from dtwsagent \
  --link dtwsagent \
  --ipc container:dtwsagent \
  --publish-all \
  httpd \
  sh -c "(sleep 1 && \${DTWSAGENT_ENV_DT}/attach-to-wsagent-master.sh &) && \
         (echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf) && \
         httpd-foreground"