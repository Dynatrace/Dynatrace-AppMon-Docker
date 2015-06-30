#! /bin/bash

mkdir -p /tmp/dynatrace/base/log
sudo docker run --rm -p 9996:9998 -v /tmp/dynatrace/base/log:/dynatrace/log -it dynatrace/dtcollector-base "$@" && \
echo Started unconfigured dynaTrace Collector exposing Agent connections on port 9996
