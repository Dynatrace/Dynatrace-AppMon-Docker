#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTAGENT_ENV_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  --volumes-from dtagent \
  --link dtcollector \
  --link dtagent \
  --env WSAGENT_NAME=httpd-agent \
  --publish-all \
  httpd \
  sh -c "\${DTAGENT_ENV_DT}/run-wsagent.sh && \
         (echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf) && \
         httpd-foreground"