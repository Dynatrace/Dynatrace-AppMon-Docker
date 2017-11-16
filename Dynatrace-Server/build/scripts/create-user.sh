#!/bin/bash

if [ ${CUID} -ne 0 ] ; then
    if [ "$(cat /etc/*release | grep ID=*alpine* | wc -l)" = "1" ] ; then
        if [ ! $(getent group ${CGID}) ]
            then
            addgroup -S -g ${CGID} dtuser && adduser -S -H -D -g dtuser -u ${CUID} -G dtuser dtuser
            else adduser -S -H -D -g dtuser -u ${CUID} dtuser
        fi
        echo "Setting ${DT_HOME} recursive ownership to user <UI:GID> ${CGID}:${CUID}"
        chown -R ${CGID}:${CUID} ${DT_HOME}
    elif [ "$(cat /etc/*release | grep ID=*debian* | wc -l)" = "1" ] ; then
        if [ ! $(getent group ${CGID}) ]
            then
            addgroup --system --gecos dtuser --gid ${CGID} dtuser && adduser --system --no-create-home --disabled-password --gecos dtuser --uid ${CUID} --gid ${CGID} dtuser
            else adduser --system --no-create-home --disabled-password --gecos dtuser --uid ${CUID} dtuser
        fi
        echo "Setting ${DT_HOME} recursive ownership to user <UI:GID> ${CGID}:${CUID}"
        chown -R ${CGID}:${CUID} ${DT_HOME}
    else echo "WARNING! Linux Distribution not recognized. New user not created!"
    fi
fi