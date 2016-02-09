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

ENV INSTALL_DEPS        "curl"

RUN apt-get update && \
    apt-get install -y ${INSTALL_DEPS} && \
    curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
    cd /tmp && \
    tar xf ./${INSTALLER_FILE_NAME} && \
    sh ./dynatrace-wsagent-*.sh && \
    mv ./dynatrace-${VERSION} ${DT} && \
    apt-get remove --purge -y ${INSTALL_DEPS} $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY build/run-process.sh /
COPY build/accept-wsagent-slaves.sh ${DT}
COPY build/attach-to-wsagent-master.sh ${DT}
COPY build/linux/x86_64/socat ${DT}

# Dynatrace Web Server Slave Agents
EXPOSE 8001/udp

ENV WAIT_FOR_CMD_URL          "https://gist.githubusercontent.com/metmajer/efec724d96cbaa20afb8/raw/36055e2f699b984c1bd009da9541679f83cfe89a/wait-for-cmd.sh"
ENV WAIT_FOR_CMD_INSTALL_DEPS "curl"
ENV WAIT_FOR_CMD_RUNTIME_DEPS "netcat"

RUN apt-get update && \
    apt-get install -y ${WAIT_FOR_CMD_INSTALL_DEPS} ${WAIT_FOR_CMD_RUNTIME_DEPS} && \
    curl -L -o /usr/local/bin/wait-for-cmd.sh ${WAIT_FOR_CMD_URL} && \
    chmod +x /usr/local/bin/wait-for-cmd.sh && \
    apt-get remove --purge -y ${WAIT_FOR_CMD_INSTALL_DEPS} && \
    rm -rf /var/lib/apt/lists/* /tmp/*

CMD /run-process.sh