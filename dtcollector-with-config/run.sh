#! /bin/bash

mkdir -p /tmp/dynatrace/dtcollector-with-config/log
sudo docker run --hostname="dtcollector-with-config" -p 9993:9998 --name=dtcollector-with-config -d -v /tmp/dynatrace/dtcollector-with-config/log:/dynatrace/log dynatrace/dtcollector-with-config "$@" && \
echo Started configured dynaTrace Collector, exposing Agent connections on port 9993