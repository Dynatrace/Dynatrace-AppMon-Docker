FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION             "6.5"
ENV INSTALLER_FILE_NAME "dynatrace-server-6.5.0.1289-linux-x86.jar"
ENV INSTALLER_URL       "http://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/6.5.0.1289/${INSTALLER_FILE_NAME}"

ENV DT                  "/dynatrace"
ENV COLLECTOR_PORT      "6698"
ENV COLLECTOR_PORT_SSL  "6699"

ENV  DT_INSTALL_DEPS "openjdk-7-jre-headless"
ENV  DT_RUNTIME_DEPS "curl procps"
RUN  apt-get update && \
     apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
     curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
     java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT} -y && \
     apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
     rm -rf /var/lib/apt/lists/* /tmp/*
COPY build/config/dtfrontendserver.ini ${DT}
COPY build/config/dtserver.ini ${DT}
COPY build/config/server.config.xml ${DT}/server/conf

COPY build/scripts/pull-license-key-file.sh /
COPY build/scripts/run-process.sh /

# Dynatrace Clients (TCP)
EXPOSE 2020
# Dynatrace Clients (TCP with SSL)
EXPOSE 2021
# Dynatrace Collectors (TCP)
EXPOSE 6698
# Dynatrace Collectors (TCP with SSL)
EXPOSE 6699
# Dynatrace Web Server (HTTP)
EXPOSE 8020
# Dynatrace Web Server (HTTPS)
EXPOSE 8021
# Dynatrace Web UI (HTTPS)
EXPOSE 9911
# Dynatrace Agents (TCP)
EXPOSE 9998

CMD /pull-license-key-file.sh ; /run-process.sh