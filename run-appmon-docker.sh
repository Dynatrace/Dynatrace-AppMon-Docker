#!/bin/bash

#build versions
DT_VERSION=${DT_VERSION:-"7.0"}
DT_BUILD_VERSION=${DT_BUILD_VERSION:-"7.0.0.2469"}

RERUN="false"
REBUILD="false"
TEST="false"

while getopts ":rbt" OPTION; do
        case $OPTION in
                "r") RERUN="true"
                ;;
                "b") REBUILD="true"
                ;;
                "t") TEST="true"
                ;;
                \?)
                    echo "Invalid option: -$OPTARG" >&2
                    exit 1
                    ;;
        esac
done

if [ "$RERUN" = "true" ] && [ -d "installation" ];
	then
		docker-compose down --rmi all
		rm -rf installation
		echo "Directory installation removed"
fi

mkdir -p ./installer

if [ $(find ./installer -name "dynatrace-*.jar" | wc -l) -eq 0 ] ;
	then
		FILENAME="dynatrace-full-${DT_BUILD_VERSION}-linux-x86-64.jar"
		URL="https://files.dynatrace.com/downloads/OnPrem/dynaTrace/${DT_VERSION}/${DT_BUILD_VERSION}/$FILENAME"
		echo "Downloading $URL..."
		curl --insecure -L -o installer/$FILENAME $URL
		SIZE=$(ls -l installer/dynatrace-full-${DT_BUILD_VERSION}-linux-x86-64.jar | awk '{print $5}')
		if [ $SIZE -le 10000 ] ; then
			echo "Downloading $FILENAME failed..."
			exit 1
		fi
		REMOTE_SIZE="$(curl -sI $URL | grep Content-Length | tr -d "\r" | awk '{printf $2}')"
		if [ "$REMOTE_SIZE" != "$SIZE" ] ; then
			echo "Downloading $URL failed..."
			exit 1
		fi
fi

if [ $(find ./scripts -name run-wsagent.sh | wc -l) -eq 1 ] ;
	then
    echo "copying run-wsagent.sh to installer directory......"
	cp ./scripts/run-wsagent.sh installer
fi

if [ $(find ./profiles -name "*profile.xml" | wc -l) -ne 0 ] ;
	then
	echo "Copying custom profiles to installer directory..."
	cp ./profiles/*profile.xml installer
fi

if [ $(find ./license -name "dtlicense.lic" | wc -l) -eq 1 ] ;
	then
	echo "Copying dtlicense.lic to installer directory..."
	cp ./license/dtlicense.lic installer
fi

#running docker-compose
if [ "$REBUILD" = "true" ];
	then
		docker-compose up -d --build
	else
		docker-compose up -d
fi


#test installation
if [ "$TEST" = "true" ];
	then
    echo "Testing installation..."
    if sudo ./test-docker-installation.sh ; then
      echo "Installation completed"
    else
      echo "Testing failed"
      exit 1
    fi
fi
