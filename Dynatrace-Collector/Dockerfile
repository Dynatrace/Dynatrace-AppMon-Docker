#DOCKERFILE FOR DYNATRACE COLLECTOR
FROM alpine:3.5

LABEL maintainer="Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG DT_HOME
ARG BUILD_VERSION
ARG VERSION
ARG CUID
ARG CGID

ENV INSTALLER_FILE_NAME=dynatrace-collector-${BUILD_VERSION}-linux-x86.jar
ENV INSTALLER_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${INSTALLER_FILE_NAME}

ENV DT_INSTALL_DEPS=curl\ openjdk8-jre-base
ENV DT_RUNTIME_DEPS=bash

RUN apk update && apk add --no-cache ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
    curl ${CURL_INSECURE:+"--insecure"} -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
	java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT_HOME} -y && \
	mkdir -p ${DT_HOME}/log/collector/dtcollector && \
	apk del ${DT_INSTALL_DEPS} && \
	rm -rf /tmp/*

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

ENV WAIT_FOR_CMD_RUNTIME_DEPS=netcat-openbsd
COPY build/scripts/wait-for-cmd.sh /usr/local/bin
RUN apk add --no-cache ${WAIT_FOR_CMD_RUNTIME_DEPS}

COPY build/scripts/create-user.sh /tmp
ENV CUID="${CUID:-0}"
ENV CGID="${CGID:-0}"
RUN /bin/sh -c /tmp/create-user.sh && rm -rf /tmp/*
USER ${CUID}:${CGID}

ENV DT_HOME=${DT_HOME}
COPY build/scripts/run-collector-process.sh ${DT_HOME}
CMD [ "sh", "-c", "${DT_HOME}/run-collector-process.sh" ]
