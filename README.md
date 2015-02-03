Docker containers for dynaTrace components
==========================================

This repository contains a collection of Docker build contexts for components of dynaTrace.

There is a base dynaTrace Collector Docker image which is extended by a derived image with 
configuration to run an actual instance of the Collector which connects to a dynaTrace 
Server and fetches the configuration.

Please feel free to contribute.

## dynaTrace Collector Docker images

#### Fork the repository

	git clone https://github.com/dynaTrace/dynatrace-docker.git

### Build the base dynaTrace Collector image

#### Download the dynaTrace Collector 

Download the full linux package named something like `dynatrace-6.1.0.7880-linux-x64.jar`
from https://community.compuwareapm.com/community/display/DL/Product+Downloads and
put it into the dtcollector-base directory.

#### Build the base image

	cd dtcollector-base
	./build.sh

### Building the configured dynaTrace Collector image

Adjust the sample configuration in `dtcollector-with-config/collector.config.xml` and the memory
settings used for the Collector in the `dtcollector-with-config/Dockerfile`, then create the image 
with the following steps:
	
	cd dtcollector-with-config
	./build.sh

### Run the dynaTrace Collector

	cd dtcollector-with-config
    ./run.sh
