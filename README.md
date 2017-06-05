![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Docker

The home of Dockerized components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution. All components are available on the [Docker Hub](https://hub.docker.com/u/dynatrace/).


## What is Dynatrace?

[Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html), with its [PurePath technology](http://www.dynatrace.com/en_us/application-performance-management/products/purepath-technology.html), is the world's leading application monitoring solution - trusted by more than 7500 customers around the globe. It supports all your major technology stacks and integrates into your Continuous Delivery pipelines to allow you to build world-class, high-quality software.


## Developed and tested on

1. docker-compose version 1.13.0, build 1719ceb
2. docker-py version: 2.2.1
3. wget latest
4. xmlstarlet


## How it works

Execution of run-appmon-docker.sh script will install full Appmon version on java based image and then it will create containers that will run Appmon Server and Appmon Collector in separated containers without the need of installing any java packages. As the result, you will see two new directories created on your host - installer and installation. The host maps volumes set in installer container. The first volume `installer` will contain Appmon java jar package and other scripts or profiles copied before installation. The second one `installation` will contain your Appmon installation.

Every other container should map 'installation' volume (in practice, they will copy content of this volume) and use it for its purpose. It allows to have one installation and many isolated Servers or Collectors configured.

If -r options is enabled it means that 'rerun' mode is turned on and it will stop and remove all docker-compose containers and images, and remove installation directory where appmon were previously installed.


## How to start

1. Run `run-appmon-docker.sh` script
```
sudo ./run-appmon-docker.sh
```
Options:
-r - it will removed your docker-compose containers, images, volumes and networks created by docker-compose and run it (as a deamon) from scratch (but keeping previously downloaded appmon jar package if exists). IMPORTANT! Needs sudo privileges!
-b - it will execute 'docker-compose up -d' with --build option
-t - it will execute tests verifying if installation finished successfully and services are running


## License

In order to activate Appmon application you need to copy your license to `license` directory.

License should have `dtlicense.lic` filename pattern.


## System Profiles

In order to detect agents, a general System Profile is attached in `profiles` directory by default. If you want to use your custom one, you need to copy it there as well.

`MyGeneralSystemProfile` detects agents which name contains `agent` word.


## Connecting Agents

In order to connect agent you need to run docker-compose up including destination path of your agent, e.g.:
```
docker-compose -f images/agent-examples/tomcat/docker-compose.yml up -d
```
-d means that it will run as a daemon process.

## Restarting

If you have already installed Appmon application on your docker containers, you can:
1. Run run-appmon-docker.sh script: 
```
./run-appmon-docker.sh
```
2. Execute: 
```
docker-compose up -d or docker-compose start -d
```

## Cleaning

1. Server/Collectors:

a) run `clean-docker.sh` script:
```
sudo ./clean-docker.sh
```
Options:
-a - it will also remove installer directory with downloaded Appmon jar package.

IMPORTANT! Needs sudo privileges and be executed in docker-compose directory!

b) Execute from your docker-compose directory:
```
docker-compose down --rmi all
sudo rm -rf installation
```
It will remove all containers, images, networks and volumes created by your docker-compose.

2. Agents

You need manually remove your agents using docker CLI.


## Troubleshooting
```
docker-compose logs
docker-compose logs installer
docker-compose logs appmon_server
docker-compose logs appmon_collector
docker-compose logs appmon_java_agent
```
optionally: -f for constant follow logs
