FROM java:7

LABEL maintainer "Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

ENV DT_HOME_JAVA=./javaexample

RUN mkdir -p $DT_HOME_JAVA

COPY build/JavaTest.java $DT_HOME_JAVA

WORKDIR $DT_HOME_JAVA

RUN javac JavaTest.java
