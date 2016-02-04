FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV VERSION             "6.2"
ENV INSTALLER_FILE_NAME "dynatrace-server-linux-x86.jar"
ENV INSTALLER_URL       "http://downloads.dynatracesaas.com/${VERSION}/${INSTALLER_FILE_NAME}"

ENV DT                  "/opt/dynatrace"
ENV COLLECTOR_PORT      "6698"
ENV COLLECTOR_PORT_SSL  "6699"

ENV INSTALL_DEPS        "openjdk-7-jre-headless"
ENV RUNTIME_DEPS        "curl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${INSTALL_DEPS} ${RUNTIME_DEPS} && \
    curl -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
    java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT} -y && \
    apt-get remove --purge -y ${INSTALL_DEPS} && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT}/dtserver.ini && \
    sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT}/dtfrontendserver.ini && \
    echo '-Dcom.dynatrace.diagnostics.filestore.numStorageThreads=1' >> ${DT}/dtserver.ini 

COPY build/pull-license-key-file.sh /
COPY build/run-process.sh /
COPY build/defaults/server.config.xml ${DT}/server/conf

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

CMD /pull-license-key-file.sh ; /run-process.sh