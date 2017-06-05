FROM glassfish:latest

LABEL maintainer "Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG AGENT_PATH

ENV GF_DOMAIN_XML_FILE="glassfish/domains/domain1/config/domain.xml"
ENV AGENT_INSTALL_DEPS="xmlstarlet"
ENV AGENT_PATH=${AGENT_PATH}

RUN apt-get update && apt-get install -y ${AGENT_INSTALL_DEPS} && \
  	xmlstarlet ed -L -s "//java-config" -t elem -n "jvm-options" -v ${AGENT_PATH} ${GF_DOMAIN_XML_FILE} && \
  	xmlstarlet ed -L -d "//java-config/jvm-options[text()=${AGENT_PATH}]" ${GF_DOMAIN_XML_FILE} && \
  	apt-get remove --purge -y ${AGENT_INSTALL_DEPS} && \
  	rm -rf /var/lib/apt/lists/* /tmp/*

CMD [ "sh", "-c", "asadmin start-domain -v"]
