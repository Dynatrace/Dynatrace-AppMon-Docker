FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION                  "6.5"
ENV AGENT_INSTALLER_URL      "http://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/6.5.0.1289/dynatrace-agent-6.5.0.1289-unix.jar"
ENV NODE_AGENT_INSTALLER_URL "http://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/6.5.0.1289/dynatrace-one-agent-nodejs-6.5.0.1289-linux-x86.tgz"
ENV WSAGENT_INSTALLER32_URL  "http://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/6.5.0.1289/dynatrace-wsagent-6.5.0.1289-linux-x86-32.tar"
ENV WSAGENT_INSTALLER64_URL  "http://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/6.5.0.1289/dynatrace-wsagent-6.5.0.1289-linux-x86-64.tar"

ENV DT                       "/dynatrace"
ENV AGENT_LIB32              "${DT}/agent/lib/libdtagent.so"
ENV AGENT_LIB64              "${DT}/agent/lib64/libdtagent.so"
ENV NODE_AGENT_LIB32         "${DT}/agent/bin/linux-x86-32/liboneagentloader.so"
ENV NODE_AGENT_LIB64         "${DT}/agent/bin/linux-x86-64/liboneagentloader.so"
ENV WSAGENT_BIN64            "${DT}/agent/lib64/dtwsagent"
ENV WSAGENT_INI              "${DT}/agent/conf/dtwsagent.ini"
ENV SLAVE_AGENT_PORT         "8001"

ENV  DT_INSTALL_DEPS "curl default-jre-headless"
ENV  DT_RUNTIME_DEPS "procps"
COPY build/scripts/install-agent.sh /usr/bin
COPY build/scripts/install-node-agent.sh /usr/bin
COPY build/scripts/install-wsagent.sh /usr/bin
RUN  apt-get update && \
     apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
     mkdir -p ${DT} && \
     install-agent.sh ${AGENT_INSTALLER_URL} && \
     install-wsagent.sh ${WSAGENT_INSTALLER32_URL} && \
     install-wsagent.sh ${WSAGENT_INSTALLER64_URL} && \
     install-node-agent.sh ${NODE_AGENT_INSTALLER_URL} && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
     rm -rf /var/lib/apt/lists/*
ADD  build/bin/dtnginx_offsets.json.tar.gz ${DT}/agent/conf
COPY build/scripts/run-wsagent.sh ${DT}

CMD while true; do sleep 1; done