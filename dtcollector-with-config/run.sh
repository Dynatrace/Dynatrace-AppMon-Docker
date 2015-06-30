#! /bin/bash

mkdir -p /tmp/dynatrace/log/dtcollector_with_config
sudo docker run --hostname="dtcollector-with-config" -p 9994:9998 --name=dtcollector_with_config -d -v /tmp/dynatrace/dtcollector_with_config/log:/dynatrace/log dynaTrace/dtcollector_with_config "$@" && \
echo Started configured dynaTrace Collector, exposing Agent connections on port 9994
