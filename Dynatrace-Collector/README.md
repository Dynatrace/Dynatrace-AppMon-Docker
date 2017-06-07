![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Collector

This project contains files for building and running the Dynatrace Collector component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/collector/).

## Build image
```
docker-compose [-f docker-compose-debian.yml] build
```

## Run a container

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you want to use `docker-compose [-f docker-compose-debian.yml] up [-d]`.

### Other commands:
In order to create container
```
docker-compose [-f docker-compose-debian.yml] create
```
In order to run already created container:
```
docker-compose [-f docker-compose-debian.yml] start
```
In order to build unbuilt image(s), (re)create container(s) and run them
```
docker-compose [-f docker-compose-debian.yml] up [-d]
```
In order to rebuild image(s), (re)create container(s) and run them
```
docker-compose [-f docker-compose-debian.yml] up [-d] --build
```

### Examples

Creates a Dockerized Dynatrace Collector instance named `dtcollector`:

```
docker-compose up -d
docker-compose logs -f
```


### Configuration

Configuration relies on supplying docker-compose with environment variables defined in .env file. Some variables need to be passed to Dockerfile via ARG for correct building an Server image, that's way it is recommended to change variables only in .env file.
Please examine the [Dynatrace Collector Configuration](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-system-components/set-up-collectors/) page for more information on the various settings.


| Environment Variable  | Defaults                    | Description
|:----------------------|:----------------------------|:-----------
| COMPOSE_PROJECT_NAME  | "dynatracedocker"                   | A name of the Project. Also used for network naming.
| DT_HOME               | "/opt/dynatrace"                   | Path to dynatrace installation directory
| DT_AGENT_NAME         | "dtagent"                   | A name that applies to both the agent and the container instance.
| DT_COLLECTOR_NAME     | "dtcollector"               | A name that applies to both the collector and the container instance.
| DT_SERVER_NAME        | "dtserver"                  | A name that applies to both the server and the container instance.
| DT_SERVER_LICENSE_KEY_FILE_URL     | N/A       | A URL to a Dynatrace License Key file (optional). If the variable remains unset, a license key has to be provided through the Dynatrace Client.
| VERSION               | "7.0"                       | GA version
| BUILD_VERSION         | "7.0.0.2469"                | Build version


Ports are also defined in .env file based on current [Communication Connections](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-communication-connections/)

List of used ports for collector:
```
APPMON_ONEAGENT_NONSSL_SERVER_PORT=8040
APPMON_ONEAGENT_SSL_SERVER_PORT=8041
APPMON_COLLECTOR_PORT=9998
APPMON_COLLECTOR_SERVER_SSL_PORT=6699
```


The following *environment variables* together form the memory configuration of the Dynatrace Collector, as described in the [Memory Configuration](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-system-components/set-up-collectors/#configure-memory) section of the [Dynatrace Collector Configuration](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-system-components/set-up-collectors/) page:

| Environment Variable           | Defaults | Description
|:-------------------------------|:---------|:-----------
| DT_COLLECTOR_JVM_XMS           | "2G"     | The collector's minimum Java heap size.
| DT_COLLECTOR_JVM_XMX           | "2G"     | The collector's maximum Java heap size.
| DT_COLLECTOR_JVM_PERM_SIZE     | "128m"   | The collector's minimum Java permanent generation size.
| DT_COLLECTOR_JVM_MAX_PERM_SIZE | "128m"   | The collector's maximum Java permanent generation size.


## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Collector&dt=Dynatrace-Docker%2FDynatrace-Collector&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
