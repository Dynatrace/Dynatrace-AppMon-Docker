#!/bin/bash
if [ ${LICENSE_KEY_FILE_URL} ]; then
  LICENSE_KEY_FILE="${DT}/server/instances/${NAME}/conf/dtlicense.key"

  mkdir -p `dirname ${LICENSE_KEY_FILE}`
  curl -L -o ${LICENSE_KEY_FILE} ${LICENSE_KEY_FILE_URL}
  chmod 0600 ${LICENSE_KEY_FILE}
fi