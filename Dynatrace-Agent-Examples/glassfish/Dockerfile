FROM glassfish:latest

LABEL maintainer="Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG DT_AGENT_PATH

ENV GF_DOMAIN_XML_FILE="glassfish/domains/domain1/config/domain.xml"
ENV DT_AGENT_INSTALL_DEPS="xmlstarlet"
ENV DT_AGENT_PATH=${DT_AGENT_PATH}

RUN apt-get update && apt-get install -y ${DT_AGENT_INSTALL_DEPS} && \
	xmlstarlet ed -L -s "//java-config" -t elem -n "jvm-options" -v ${DT_AGENT_PATH} ${GF_DOMAIN_XML_FILE} && \
	xmlstarlet ed -L -d "//java-config/jvm-options[text()=${DT_AGENT_PATH}]" ${GF_DOMAIN_XML_FILE} && \  
	apt-get remove --purge -y ${DT_AGENT_INSTALL_DEPS} && \
	rm -rf /var/lib/apt/lists/* /tmp/*

CMD [ "sh", "-c", "asadmin start-domain -v"]