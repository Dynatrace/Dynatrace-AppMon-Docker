#DOCKERFILE FOR DYNATRACE SERVER
FROM alpine:3.5

LABEL maintainer "Martin Etmajer <martin.etmajer@dynatrace.com>"
LABEL maintainer2 "Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG DT_HOME
ARG BUILD_VERSION
ARG VERSION
ARG DT_SERVER_LICENSE_KEY_FILE_URL

ENV INSTALLER_FILE_NAME=dynatrace-server-${BUILD_VERSION}-linux-x86.jar
ENV INSTALLER_URL=https://s3.amazonaws.com/downloads.dynatracesaas.com/${VERSION}/EAP/${INSTALLER_FILE_NAME}

ENV COLLECTOR_PORT=6698
ENV COLLECTOR_PORT_SSL=6699

ENV DT_INSTALL_DEPS=openjdk8-jre-base
ENV DT_RUNTIME_DEPS=bash\ curl

RUN apk update && apk add --no-cache ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
    curl --insecure -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
	java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT_HOME} -y && \
	apk del ${DT_INSTALL_DEPS} && \
	rm -rf /tmp/*
RUN sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT_HOME}/dtserver.ini && \
	sed -i '/^-memory/,/^unsupported/c\-memory\ndemo' ${DT_HOME}/dtfrontendserver.ini && \
	echo '-Dcom.dynatrace.diagnostics.filestore.numStorageThreads=1' >> ${DT_HOME}/dtserver.ini

COPY /build/config/server.config.xml ${DT_HOME}/server/conf

ENV GLIBC_RUNTIME_DEPS=libgcc

COPY build/bin/glibc-2.21-r2.apk /tmp
COPY build/bin/glibc-bin-2.21-r2.apk /tmp

RUN apk add --no-cache ${GLIBC_RUNTIME_DEPS} && \
	apk add --allow-untrusted /tmp/glibc-2.21-r2.apk && \
	apk add --allow-untrusted /tmp/glibc-bin-2.21-r2.apk && \
	/usr/glibc/usr/bin/ldconfig /lib /usr/glibc/usr/lib && \
	rm -rf /tmp/*

# Make sure that hostname resolution looks up /etc/hosts prior to /etc/resolv.conf
RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf

COPY /build/scripts/pull-license-key-file.sh ${DT_HOME}
COPY /build/scripts/run-server-process.sh ${DT_HOME}

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

ENV DT_HOME=${DT_HOME}
ENV DT_SERVER_LICENSE_KEY_FILE_URL=${DT_SERVER_LICENSE_KEY_FILE_URL}
CMD [ "sh", "-c", "${DT_HOME}/pull-license-key-file.sh ; ${DT_HOME}/run-server-process.sh" ]
