#!/bin/bash -e

ALL="false"

while getopts ":a" OPTION ; do
        case $OPTION in
          a)
              ALL="true"
              ;;
          \?)
              echo >&2 "Invalid option: -$OPTARG"W
              exit 1
              ;;
        esac
done

docker-compose down --rmi all

if [ -d "installation" ] ; then
		rm -rf installation
		echo "Directory installation removed"
fi

if [ "$ALL" = "true" ] && [ -d "installer" ]; then
    rm -rf installer
    echo "Directory installer removed"
fi
