#!/bin/bash

if [ "`find /installation -name installed | wc -l`" -eq 0 ]
then
	if [ `find /installer -name "dynatrace-*.jar" | wc -l` -ne 1 ]
	then
		>&2 echo "No installer found or found more than one."
		exit 1
	fi

	java -jar /installer/dynatrace-*.jar -y -t /installation

	mv /installation/collector/conf/collector.config.xml /installation/collector/conf/collector.config.xml.bak
	xmlstarlet ed -u /dynatrace/collectorconfig/@serveraddress -v appmon_server /installation/collector/conf/collector.config.xml.bak >/installation/collector/conf/collector.config.xml

	touch /installation/installed
fi

#copy run-wsagent in order to run agents
if [ `find /installer -name "run-wsagent.sh" | wc -l` -eq 1 ]
	then
		cp /installer/run-wsagent.sh /installation
	else
		>&2 echo "No run-wsagent found or found more than one."
fi

#copy custom profiles in order to instrument agents
if [ `find /installer -name "*profile.xml" | wc -l` -ne 0 ]
	then
		mkdir -p /installation/server/conf/profiles
		cp /installer/*profile.xml /installation/server/conf/profiles
		chmod 0644 /installation/server/conf/profiles/*profile.xml
	else
		>&2 echo "No profiles found in installer folder"
fi

#copy run-wsagent in order to run agents
if [ `find /installer/ -name "dtlicense.lic" | wc -l` -eq 1 ]
	then
		cp /installer/dtlicense.lic /installation/server/conf/dtlicense.lic
		rm /installer/dtlicense.lic
		chmod 0600 /installation/server/conf/dtlicense.lic
		>&2 echo "License copied"
	else
		>&2 echo "No license found or found more than one."
fi
