#!/bin/bash
DT_AGENT_NAME=${TOMCAT_DT_AGENT_NAME:-"tomcat-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_AGENT_LIB64}=name=${TOMCAT_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"

echo "Starting Apache Tomcat - Example"
docker run --rm \
  --name tomcat-example \
  --volumes-from dtagent \
  --link dtagent \
  --link dtcollector \
  --publish-all \
  tomcat \
  sh -c "CATALINA_OPTS=${DT_AGENT_PATH} catalina.sh run"
