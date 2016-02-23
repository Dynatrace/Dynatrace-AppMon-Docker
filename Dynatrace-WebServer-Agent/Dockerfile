FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION             "6.2"
ENV INSTALLER_FILE_NAME "dynatrace-wsagent-linux-x64.tar"
ENV INSTALLER_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER_FILE_NAME}"

ENV DT                  "/dynatrace"
ENV BIN64               "${DT}/agent/lib64/dtwsagent"
ENV INI                 "${DT}/agent/conf/dtwsagent.ini"
ENV LIB64               "${DT}/agent/lib64/libdtagent.so"
ENV SLAVE_AGENT_PORT    "8001"

ENV  DT_INSTALL_DEPS "curl"
RUN  apt-get update && \
     apt-get install -y ${DT_INSTALL_DEPS} && \
     curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
     cd /tmp && \
     tar xf ./${INSTALLER_FILE_NAME} && \
     sh ./dynatrace-wsagent-*.sh && \
     mv ./dynatrace-${VERSION} ${DT} && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} $(apt-mark showauto) && \
     rm -rf /var/lib/apt/lists/* /tmp/*
ADD  build/bin/dtnginx_offsets.json.tar.gz ${DT}/agent/conf
COPY build/scripts/run-wsagent-master.sh ${DT}

CMD while true; do sleep 1; done