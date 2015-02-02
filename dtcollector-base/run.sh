#! /bin/bash

# -d ... detached
mkdir -p /tmp/dynatrace/log
sudo docker run --rm -p 9996:9998 -v /tmp/dynatrace/log:/dynatrace/log -it centic9/dtcollector-base "$@" && \
echo Started unconfigured dynaTrace Collector exposing Agent connections on port 9996
