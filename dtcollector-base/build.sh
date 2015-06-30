#! /bin/bash

DYNATRACE_VERSION=6.2

if [ ! -f dynatrace-${DYNATRACE_VERSION}.0.*-linux-x64.jar ];then
	echo Should find the full installation jar of dynatrace named like dynatrace-${DYNATRACE_VERSION}.0.*-linux-x64.jar in current folder
	exit 1
fi

if [ ! -d dynatrace-${DYNATRACE_VERSION}.0 ];then
	echo Extracting dynaTrace installation package dynatrace-${DYNATRACE_VERSION}.0.*-linux-x64.jar
	echo -e "Y\nY" | java -jar dynatrace-${DYNATRACE_VERSION}.0.*-linux-x64.jar
fi

TAG=${DYNATRACE_VERSION}-`date +%Y%m%d-%H%M%S`

echo "Building Docker image"
sudo docker build -t dynaTrace/dtcollector-base:${TAG} .
if [ $? -ne 0 ];then
	echo "Failed to build Docker image"
	exit 1
fi

echo "Pushing image with tag ${TAG} to Docker registry, using dynaTrace version ${DYNATRACE_VERSION}"
sudo docker tag dynaTrace/dtcollector-base:${TAG} dynaTrace/dtcollector-base:${DYNATRACE_VERSION}-latest
sudo docker tag dynaTrace/dtcollector-base:${TAG} dynaTrace/dtcollector-base:latest
