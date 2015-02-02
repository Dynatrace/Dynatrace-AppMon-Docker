#! /bin/bash

# -d ... detached
mkdir -p /tmp/dynatrace/log
sudo docker run --hostname="dtcollector-with-config" -p 9994:9998 --name=dtcollector_with_config -d -v /tmp/dynatrace/sprint/log:/dynatrace/log centic9/dtcollector_with_config "$@" && \
echo Started configured dynaTrace Collector, exposing Agent connections on port 9994
