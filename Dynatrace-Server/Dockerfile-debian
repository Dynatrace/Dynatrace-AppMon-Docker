#DOCKERFILE FOR DYNATRACE SERVER
FROM debian:jessie

LABEL maintainer="Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG DT_HOME
ARG BUILD_VERSION
ARG VERSION
ARG DT_SERVER_LICENSE_KEY_FILE_URL
ARG CUID
ARG CGID

ENV INSTALLER_FILE_NAME=dynatrace-full-${BUILD_VERSION}-linux-x86-64.jar
ENV INSTALLER_URL=https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${VERSION}/${BUILD_VERSION}/${INSTALLER_FILE_NAME}

ENV DT_INSTALL_DEPS=openjdk-8-jre-headless
ENV DT_RUNTIME_DEPS=curl\ procps

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list && \
	apt-get update -y && apt-get install -y --no-install-recommends -t jessie-backports ${DT_INSTALL_DEPS} ${DT_RUNTIME_DEPS} && \
    curl ${CURL_INSECURE:+"--insecure"} -L -o /tmp/${INSTALLER_FILE_NAME} ${INSTALLER_URL} && \
	java -jar /tmp/${INSTALLER_FILE_NAME} -b 64 -t ${DT_HOME} -y && \
	mkdir -p ${DT_HOME}/log/server/dtserver && \
    apt-get remove --purge -y ${DT_INSTALL_DEPS} && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY build/config/dtfrontendserver.ini ${DT_HOME}
COPY build/config/dtserver.ini ${DT_HOME}
COPY build/config/server.config.xml ${DT_HOME}/server/conf

COPY build/scripts/pull-license-key-file.sh ${DT_HOME}
COPY build/scripts/run-server-process.sh ${DT_HOME}
COPY build/scripts/create-user.sh /tmp

ENV CUID="${CUID:-0}"
ENV CGID="${CGID:-0}"
RUN /bin/sh -c /tmp/create-user.sh && rm -rf /tmp/*
USER ${CUID}:${CGID}

ENV DT_HOME=${DT_HOME}
ENV DT_SERVER_LICENSE_KEY_FILE_URL=${DT_SERVER_LICENSE_KEY_FILE_URL}
CMD [ "sh", "-c", "${DT_HOME}/pull-license-key-file.sh ; ${DT_HOME}/run-server-process.sh" ]
