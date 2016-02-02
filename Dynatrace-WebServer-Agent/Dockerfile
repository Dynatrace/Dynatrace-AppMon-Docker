FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV DT_WSAGENT_VERSION          "6.2"
ENV DT_WSAGENT_FILE_NAME        "dynatrace-wsagent-linux-x64.tar"
ENV DT_WSAGENT_URL              "http://downloads.dynatracesaas.com/${DT_WSAGENT_VERSION}/${DT_WSAGENT_FILE_NAME}"

ENV DT_WSAGENT_HOME             "/opt/dynatrace"
ENV DT_WSAGENT_BIN64            "${DT_WSAGENT_HOME}/agent/lib64/dtwsagent"
ENV DT_WSAGENT_LIB64            "${DT_WSAGENT_HOME}/agent/lib64/libdtagent.so"
ENV DT_WSAGENT_INI              "${DT_WSAGENT_HOME}/agent/conf/dtwsagent.ini"
ENV DT_WSAGENT_SLAVE_AGENT_PORT "8001"

ENV DT_INSTALL_DEPS             "curl"

RUN apt-get update && \
    apt-get install -y ${DT_INSTALL_DEPS} && \
    curl -L -o /tmp/${DT_WSAGENT_FILE_NAME} ${DT_WSAGENT_URL} && \
    cd /tmp && \
    tar xf ./${DT_WSAGENT_FILE_NAME} && \
    sh ./dynatrace-wsagent-*.sh && \
    mv ./dynatrace-${DT_WSAGENT_VERSION} ${DT_WSAGENT_HOME} && \
    apt-get remove --purge -y ${DT_INSTALL_DEPS} $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY build/run-process.sh /
COPY build/attach-to-wsagent-master.sh ${DT_WSAGENT_HOME}
COPY build/accept-wsagent-slaves.sh ${DT_WSAGENT_HOME}

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

ENV SOCAT_HOME "/opt/dynatrace/socat"

RUN mkdir -p ${SOCAT_HOME}

COPY build/linux/x86_64/socat ${SOCAT_HOME}

CMD /run-process.sh