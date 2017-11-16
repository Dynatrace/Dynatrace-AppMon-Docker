#DOCKERFILE FOR DYNATRACE AGENT
FROM debian:jessie

LABEL maintainer="Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG DT_HOME
ARG BUILD_VERSION
ARG VERSION

ENV AGENT_INSTALLER_NAME=dynatrace-agent-${BUILD_VERSION}-unix.jar
ENV WSAGENT_INSTALLER32_NAME=dynatrace-wsagent-${BUILD_VERSION}-linux-x86-32.tar
ENV WSAGENT_INSTALLER64_NAME=dynatrace-wsagent-${BUILD_VERSION}-linux-x86-64.tar
ENV NODE_AGENT_INSTALLER_NAME=dynatrace-one-agent-nodejs-${BUILD_VERSION}-linux-x86.tgz
ENV AGENT_INSTALLER_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${AGENT_INSTALLER_NAME}
ENV WSAGENT_INSTALLER32_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${WSAGENT_INSTALLER32_NAME}
ENV WSAGENT_INSTALLER64_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${WSAGENT_INSTALLER64_NAME}
ENV NODE_AGENT_INSTALLER_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${NODE_AGENT_INSTALLER_NAME}

ENV SLAVE_AGENT_PORT=8001

ENV DT_INSTALL_DEPS=curl\ default-jre-headless
ENV DT_RUNTIME_DEPS=procps

COPY build/scripts/install-agent.sh /usr/bin
COPY build/scripts/install-node-agent.sh /usr/bin
COPY build/scripts/install-wsagent.sh /usr/bin

RUN  apt-get update -y && apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
     mkdir -p ${DT_HOME} && \
     /usr/bin/install-agent.sh ${AGENT_INSTALLER_URL} && \
     /usr/bin/install-wsagent.sh ${WSAGENT_INSTALLER32_URL} && \
     /usr/bin/install-wsagent.sh ${WSAGENT_INSTALLER64_URL} && \
     /usr/bin/install-node-agent.sh ${NODE_AGENT_INSTALLER_URL} && \
	 mkdir -p ${DT_HOME}/log/agent && \
	 rm -rf /tmp/* && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
     rm -rf /var/lib/apt/lists/*
ADD  build/bin/dtnginx_offsets.json.tar.gz ${DT_HOME}/agent/conf
COPY build/scripts/run-wsagent.sh ${DT_HOME}

COPY build/scripts/create-user.sh /tmp
ENV CUID="${CUID:-0}"
ENV CGID="${CGID:-0}"
RUN /bin/sh -c /tmp/create-user.sh && rm -rf /tmp/*
USER ${CUID}:${CGID}

CMD while true; do sleep 1; done
