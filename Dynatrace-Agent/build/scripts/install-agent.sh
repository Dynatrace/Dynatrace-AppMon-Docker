#!/bin/bash
INSTALLER_URL="$1"
INSTALLER_FILE_NAME=`basename ${INSTALLER_URL}`

cd /tmp
curl -L -O ${INSTALLER_URL}
java -jar ./${INSTALLER_FILE_NAME} -y
cp -R ./dynatrace-${VERSION}/* ${DT}
rm -rf /tmp/*