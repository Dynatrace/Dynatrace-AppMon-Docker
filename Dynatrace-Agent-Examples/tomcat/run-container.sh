#!/bin/bash
TOMCAT_DT_AGENT_NAME=${TOMCAT_DT_AGENT_NAME:-"tomcat-agent"}
TOMCAT_DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_DT_AGENT_LIB64}=name=${TOMCAT_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_DT_COLLECTOR_HOST_NAME}:\${DTCOLLECTOR_ENV_DT_COLLECTOR_AGENT_PORT}"

echo "Starting Apache Tomcat - Example"
docker run --rm \
  --name tomcat-example \
  --link dtagent \
  --link dtcollector \
  --volumes-from dtagent \
  --publish-all \
  tomcat \
  sh -c "CATALINA_OPTS=${TOMCAT_DT_AGENT_PATH} catalina.sh run"