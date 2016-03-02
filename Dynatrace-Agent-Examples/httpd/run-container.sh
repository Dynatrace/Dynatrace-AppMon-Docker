#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTAGENT_ENV_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  --env DT_AGENT_NAME=httpd-agent \
  --volumes-from dtagent \
  --link dtagent \
  --link dtcollector \
  --publish-all \
  httpd \
  sh -c "\${DTAGENT_ENV_DT}/run-wsagent.sh && \
         (echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf) && \
         httpd-foreground"