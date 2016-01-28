FROM debian:wheezy

MAINTAINER Martin Etmajer <martin.etmajer@dynatrace.com>

ENV DT_SERVER_VERSION            "6.2"
ENV DT_SERVER_FILE_NAME          "dynatrace-server-linux-x86.jar"
ENV DT_SERVER_URL                "http://downloads.dynatracesaas.com/${DT_SERVER_VERSION}/${DT_SERVER_FILE_NAME}"

ENV DT_SERVER_HOME               "/opt/dynatrace"
ENV DT_SERVER_COLLECTOR_PORT     "6698"
ENV DT_SERVER_COLLECTOR_PORT_SSL "6699"

ENV DT_INSTALL_DEPS              "openjdk-7-jre-headless"
ENV DT_RUNTIME_DEPS              "curl"

RUN apt-get update && \
    apt-get install -y --no-install-recommends ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
    curl -L -o /tmp/${DT_SERVER_FILE_NAME} ${DT_SERVER_URL} && \
    java -jar /tmp/${DT_SERVER_FILE_NAME} -b 64 -t ${DT_SERVER_HOME} -y && \
    apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT_SERVER_HOME}/dtserver.ini && \
    sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT_SERVER_HOME}/dtfrontendserver.ini && \
    echo '-Dcom.dynatrace.diagnostics.filestore.numStorageThreads=1' >> ${DT_SERVER_HOME}/dtserver.ini 

COPY build/pull-license-key-file.sh /
COPY build/run-process.sh /

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