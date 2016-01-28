#!/bin/bash
JAVA_DT_AGENT_NAME="java-agent"
JAVA_DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_DT_AGENT_LIB64}=name=${JAVA_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_DT_COLLECTOR_HOST_NAME}"

echo "Starting Java - Example"
docker run --rm \
  --name java-example \
  --link dtagent \
  --link dtcollector \
  --volumes-from dtagent \
  dynatrace/java-example \
  sh -c "java ${JAVA_DT_AGENT_PATH} JavaTest"