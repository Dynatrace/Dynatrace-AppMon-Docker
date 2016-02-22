FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION             "6.2"
ENV INSTALLER_FILE_NAME "dynatrace-collector-linux-x86.jar"
ENV INSTALLER_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER_FILE_NAME}"

ENV DT                  "/dynatrace"
ENV AGENT_PORT          "9998"

ENV  DT_INSTALL_DEPS "curl openjdk-7-jre-headless"
COPY build/scripts/run-process.sh /
RUN  apt-get update && \
     apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} && \
     curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
     java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT} -y && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} $(apt-mark showauto) && \
     rm -rf /var/lib/apt/lists/* /tmp/*

ENV  WAIT_FOR_CMD_RUNTIME_DEPS "netcat"
COPY build/scripts/wait-for-cmd.sh /usr/local/bin
RUN  apt-get update && \
     apt-get install -y ${WAIT_FOR_CMD_RUNTIME_DEPS} && \
     rm -rf /var/lib/apt/lists/* /tmp/*

# Dynatrace Agents (TCP)
EXPOSE 9998

CMD /run-process.sh