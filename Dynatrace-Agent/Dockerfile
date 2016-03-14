FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION                 "6.3"
ENV NODE_INSTALLER64_URL    "http://downloads.dynatracesaas.com/${VERSION}/dynatrace-nodejsagent-linux-x64.tgz"
ENV WSAGENT_INSTALLER32_URL "http://downloads.dynatracesaas.com/${VERSION}/dynatrace-wsagent-linux-x86.tar"
ENV WSAGENT_INSTALLER64_URL "http://downloads.dynatracesaas.com/${VERSION}/dynatrace-wsagent-linux-x64.tar"

ENV DT                      "/dynatrace"
ENV BIN64                   "${DT}/agent/lib64/dtwsagent"
ENV INI                     "${DT}/agent/conf/dtwsagent.ini"
ENV LIB32                   "${DT}/agent/lib/libdtagent.so"
ENV LIB64                   "${DT}/agent/lib64/libdtagent.so"
ENV SLAVE_AGENT_PORT        "8001"

ENV  DT_INSTALL_DEPS "curl"
ENV  DT_RUNTIME_DEPS "procps"
COPY build/scripts/install-node-agent.sh /usr/bin
COPY build/scripts/install-wsagent.sh /usr/bin
RUN  apt-get update && \
     apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
     mkdir -p ${DT} && \
     install-wsagent.sh ${WSAGENT_INSTALLER32_URL} && \
     install-wsagent.sh ${WSAGENT_INSTALLER64_URL} && \
     install-node-agent.sh ${NODE_INSTALLER64_URL} && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
     rm -rf /var/lib/apt/lists/*
ADD  build/bin/dtnginx_offsets.json.tar.gz ${DT}/agent/conf
COPY build/scripts/run-wsagent.sh ${DT}

CMD while true; do sleep 1; done