FROM java:8

LABEL maintainer "Blazej Tomaszewski <blazej.tomaszewski@dynatrace.com>"

RUN apt-get update && apt-get install -y xmlstarlet

COPY ./install.sh /install.sh

ENTRYPOINT /install.sh
