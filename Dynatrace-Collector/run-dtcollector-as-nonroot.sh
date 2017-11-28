#!/bin/bash

REBUILD="false"
FILENAME=""

while getopts ":f:b" opt; do
  case $opt in
    f)
      FILENAME="$OPTARG"
    ;;
    b)
      REBUILD="true"
    ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

DT_COLLECTOR_LOG_PATH_ON_HOST=${DT_COLLECTOR_LOG_PATH_ON_HOST:-"/tmp/log/dynatrace/collectors/dtcollector"}

mkdir -p ${DT_COLLECTOR_LOG_PATH_ON_HOST}

OWNER=$(stat -c '%U' ${DT_COLLECTOR_LOG_PATH_ON_HOST})
if [ "${OWNER}" != "${USER}" ] ; then
    echo "Directory has invalid ownership set to '${OWNER}', change it to current user or remove it: ${DT_COLLECTOR_LOG_PATH_ON_HOST}" >&2
    echo "Aborting..." >&2
    exit 1
fi

PARAMS=""
if [ ! -z "$FILENAME" ] ; then
    PARAMS="$PARAMS -f $FILENAME"
fi
PARAMS="$PARAMS up -d"
if [ "$REBUILD" = "true" ] ; then
    PARAMS="$PARAMS --build"
fi

docker-compose ${PARAMS}