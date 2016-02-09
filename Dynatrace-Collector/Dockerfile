FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION             "6.2"
ENV INSTALLER_FILE_NAME "dynatrace-collector-linux-x86.jar"
ENV INSTALLER_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER_FILE_NAME}"

ENV DT                  "/dynatrace"
ENV AGENT_PORT          "9998"

ENV INSTALL_DEPS        "curl openjdk-7-jre-headless"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${INSTALL_DEPS} && \
    curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
    java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT} -y && \
    apt-get remove --purge -y ${INSTALL_DEPS} $(apt-mark showauto) && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY build/run-process.sh /

# Dynatrace Agents (TCP)
EXPOSE 9998

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