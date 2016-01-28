#!/bin/bash
GLASSFISH_DOMAIN_XML_FILE=${GLASSFISH_DOMAIN_XML_FILE}

GLASSFISH_DT_AGENT_NAME=${GLASSFISH_DT_AGENT_NAME:-"glassfish-agent"}
GLASSFISH_DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_DT_AGENT_LIB64}=name=${GLASSFISH_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_DT_COLLECTOR_HOST_NAME}:\${DTCOLLECTOR_ENV_DT_COLLECTOR_AGENT_PORT}"
GLASSFISH_DT_AGENT_INSTALL_DEPS="xmlstarlet"

echo "Starting GlassFish - Example"
docker run --rm \
  --name glassfish-example \
  --link dtagent \
  --link dtcollector \
  --volumes-from dtagent \
  --publish-all \
  glassfish \
  sh -c "apt-get update && apt-get install ${GLASSFISH_DT_AGENT_INSTALL_DEPS} && \
         xmlstarlet ed -L -s '//java-config' -t elem -n 'jvm-options' -v '${GLASSFISH_DT_AGENT_PATH}' ${GLASSFISH_DOMAIN_XML_FILE} && \
         xmlstarlet ed -L -d '//java-config/jvm-options[text()=${GLASSFISH_DT_AGENT_PATH}]' ${GLASSFISH_DOMAIN_XML_FILE} && \
         apt-get remove --purge -y ${GLASSFISH_DT_AGENT_INSTALL_DEPS} && \
         rm -rf /var/lib/apt/lists/* /tmp/* && \
         asadmin start-domain -v"