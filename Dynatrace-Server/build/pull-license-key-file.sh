#!/bin/bash
if [ ${DT_SERVER_LICENSE_KEY_FILE_URL} ]; then
  DT_SERVER_LICENSE_KEY_FILE="${DT_SERVER_HOME}/server/instances/${DT_SERVER_NAME}/conf/dtlicense.key"

  mkdir -p `dirname ${DT_SERVER_LICENSE_KEY_FILE}`
  curl -L -o ${DT_SERVER_LICENSE_KEY_FILE} ${DT_SERVER_LICENSE_KEY_FILE_URL}
  chmod 0600 ${DT_SERVER_LICENSE_KEY_FILE}
fi