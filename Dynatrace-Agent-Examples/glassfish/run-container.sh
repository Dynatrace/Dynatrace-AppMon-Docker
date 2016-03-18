#!/bin/bash
GF_DOMAIN_XML_FILE="glassfish/domains/domain1/config/domain.xml"

DT_AGENT_NAME=${GF_DT_AGENT_NAME:-"glassfish-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_AGENT_LIB64}=name=${DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"
DT_AGENT_INSTALL_DEPS="xmlstarlet"

echo "Starting GlassFish - Example"
docker run --rm \
  --name glassfish-example \
  --volumes-from dtagent \
  --link dtagent \
  --link dtcollector \
  --publish-all \
  glassfish \
  sh -c "apt-get update && apt-get install -y ${DT_AGENT_INSTALL_DEPS} && \
         xmlstarlet ed -L -s '//java-config' -t elem -n 'jvm-options' -v '${DT_AGENT_PATH}' ${GF_DOMAIN_XML_FILE} && \
         xmlstarlet ed -L -d '//java-config/jvm-options[text()=${DT_AGENT_PATH}]' ${GF_DOMAIN_XML_FILE} && \
         apt-get remove --purge -y ${DT_AGENT_INSTALL_DEPS} && \
         rm -rf /var/lib/apt/lists/* /tmp/* && \
         asadmin start-domain -v"