#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTWSAGENT_ENV_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  --volumes-from dtwsagent \
  --link dtcollector \
  --link dtwsagent \
  --env AGENT_NAME=httpd-agent \
  --publish-all \
  httpd \
  sh -c "\${DTWSAGENT_ENV_DT}/run-wsagent-master.sh && \
         (echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf) && \
         httpd-foreground"