FROM java:7

LABEL maintainer="Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ARG AGENT_LIB64_PATH
ARG DT_COLLECTOR_NAME

ENV DT_HOME_JAVA=${DT_HOME}/javaexample

ENV JAVA_OPTS="-agentpath:${AGENT_LIB64_PATH}=name=java-agent,collector=${DT_COLLECTOR_NAME}"

RUN mkdir -p ${DT_HOME_JAVA}

COPY build/JavaTest.java ${DT_HOME_JAVA}

WORKDIR ${DT_HOME_JAVA}

RUN javac JavaTest.java
CMD java ${JAVA_OPTS} JavaTest