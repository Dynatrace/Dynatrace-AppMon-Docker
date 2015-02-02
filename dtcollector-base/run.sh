#! /bin/bash

mkdir -p /tmp/dynatrace/log/base
sudo docker run --rm -p 9996:9998 -v /tmp/dynatrace/log/base:/dynatrace/log -it centic9/dtcollector-base "$@" && \
echo Started unconfigured dynaTrace Collector exposing Agent connections on port 9996
