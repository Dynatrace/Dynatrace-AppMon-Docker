FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION               "6.3"
ENV INSTALLER32_FILE_NAME "dynatrace-wsagent-linux-x86.tar"
ENV INSTALLER64_FILE_NAME "dynatrace-wsagent-linux-x64.tar"
ENV INSTALLER32_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER32_FILE_NAME}"
ENV INSTALLER64_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER64_FILE_NAME}"

ENV DT                    "/dynatrace"
ENV BIN64                 "${DT}/agent/lib64/dtwsagent"
ENV INI                   "${DT}/agent/conf/dtwsagent.ini"
ENV LIB32                 "${DT}/agent/lib/libdtagent.so"
ENV LIB64                 "${DT}/agent/lib64/libdtagent.so"
ENV SLAVE_AGENT_PORT      "8001"

ENV  DT_INSTALL_DEPS "curl"
ENV  DT_RUNTIME_DEPS "procps"
RUN  apt-get update && \
     apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
     cd /tmp && \
     curl -L -o ./${INSTALLER64_FILE_NAME} ${INSTALLER64_URL} && \
     tar xf ./${INSTALLER64_FILE_NAME} && \
     sh ./dynatrace-wsagent-*.sh && \
     mv ./dynatrace-${VERSION} ${DT} && \
     rm -rf /tmp/* && \
     curl -L -o ./${INSTALLER32_FILE_NAME} ${INSTALLER32_URL} && \
     tar xf ./${INSTALLER32_FILE_NAME} && \
     sh ./dynatrace-wsagent-*.sh && \
     mv ./dynatrace-${VERSION}/agent/lib ${DT}/agent && \
     rm -rf /tmp/* && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
     rm -rf /var/lib/apt/lists/*
ADD  build/bin/dtnginx_offsets.json.tar.gz ${DT}/agent/conf
COPY build/scripts/run-wsagent.sh ${DT}

CMD while true; do sleep 1; done