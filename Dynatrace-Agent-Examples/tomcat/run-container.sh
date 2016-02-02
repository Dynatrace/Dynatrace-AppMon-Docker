#!/bin/bash
DT_AGENT_NAME=${TOMCAT_DT_AGENT_NAME:-"tomcat-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_LIB64}=name=${TOMCAT_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"

echo "Starting Apache Tomcat - Example"
docker run -ti \
  --name tomcat-example \
  --link dtagent \
  --link dtcollector \
  --volumes-from dtagent \
  --publish-all \
  tomcat \
  sh -c "CATALINA_OPTS=${DT_AGENT_PATH} catalina.sh run"
