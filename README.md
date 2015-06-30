Docker containers for Dynatrace components
==========================================

This repository contains a collection of Docker build contexts for components of Dynatrace.

Dynatrace Collectors are usually well suited for dockerization as they fetch most of their 
configuration data from the Dynatrace server during startup and thus they can easily be 
re-created from scratch without the need for backing up any data except for one configuration
file which can easily be added to the Docker-image.

Directory `dtcollector-base` provides a base Dynatrace Collector Docker image which is extended by 
a sample derived image in `dtcollector-with-config` which also includes the actual configuration to 
run an instance of the Collector that connects to a Dynatrace Server.

Please feel free to contribute.

## Dynatrace Collector Docker images

#### Fork the repository

	git clone https://github.com/dynaTrace/dynatrace-docker.git

### Build the base Dynatrace Collector image

#### Download the Dynatrace Collector 

Download the full linux package named something like `dynatrace-6.2.0.1238-linux-x64.jar`
from https://community.compuwareapm.com/community/display/DL/Product+Downloads and
put it into the dtcollector-base directory.

#### Build the base image

	cd dtcollector-base
	./build.sh

### Building the configured Dynatrace Collector image

Adjust the configuration in `dtcollector-with-config/collector.config.xml` (usually only the actual Dynatrace Server hostname is needed instead of `localhost` in field `serveraddress`).

Adjust the memory settings used for the Collector in the `dtcollector-with-config/Dockerfile`, then create the image 
with the following steps:
	
	cd dtcollector-with-config
	./build.sh

### Run the Dynatrace Collector

	cd dtcollector-with-config
    ./run.sh

### Run multiple Dynatrace Collectors on one machine

The Docker Container also makes it easy to run multiple Dynatrace Collectors on one machine, the only
port that is usually required is the Agent connection port. Look at the file `dtcollector-with-config/run.sh`
it maps the port 9998 inside the container to a different port on the host-machine. By using different ones
for different Containers you can run multiple Dynatrace Collectors on one machine, each providing the Agent
connection on a different port without needing to adjust configuration of the Dynatrace Collector itself.
