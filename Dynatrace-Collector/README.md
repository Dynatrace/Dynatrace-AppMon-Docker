![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Collector

This project contains files for building and running the Dynatrace Collector component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/collector/).

<br>

---
**TL;DR**: you can quickly spawn a `dynatrace/collector` instance with an anticipated default configuration by invoking:

```
docker-compose up
```
---
<br>

## Option A: Run a container via `run-container.sh`

The `run-container.sh` script runs a Docker container using `docker run` and additionally shows by example how the `dynatrace/collector` Docker image can be effectively configured at runtime. Please make sure to validate these settings to match your environment, as described below:

### Configuration

You can override the default configuration by providing the following *environment variables* to the script. Please examine the [Dynatrace Collector Configuration](https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration) page for more information on the various settings.

| Environment Variable      | Defaults                        | Description
|:--------------------------|:--------------------------------|:-----------
| DT_COLLECTOR_NAME         | "dtcollector"                   | A name that applies to both the collector and the container instance.
| DT_COLLECTOR_GROUP_NAME   | n/a                             | An optional name of the collector group the collector shall be a member of.
| DT_COLLECTOR_HOST_LOG_DIR | "/tmp/log/${DT_COLLECTOR_NAME}" | A directory on the host the collector logs shall be mapped to.
| DT_COLLECTOR_HOST_NAME    | "docker-${DT_COLLECTOR_NAME}"   | A hostname that applies to the container instance (within Docker).
| DT_COLLECTOR_SERVER       | n/a                             | An optional "host:port" combination to a Dynatrace Server. A [Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Server) running in Docker will be auto-discovered if the collector container links to the server container via `--link dtserver`.

The following *environment variables* together form the memory configuration of the Dynatrace Collector, as described in the [Memory Configuration](https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration#CollectorConfiguration-MemoryConfiguration) section of the [Dynatrace Collector Configuration](https://community.dynatrace.com/community/display/DOCDT62/Collector+Configuration) page:

| Environment Variable           | Defaults | Description
|:-------------------------------|:---------|:-----------
| DT_COLLECTOR_JVM_XMS           | "2G"     | The collector's minimum Java heap size.
| DT_COLLECTOR_JVM_XMX           | "2G"     | The collector's maximum Java heap size.
| DT_COLLECTOR_JVM_PERM_SIZE     | "128m"   | The collector's minimum Java permanent generation size.
| DT_COLLECTOR_JVM_MAX_PERM_SIZE | "128m"   | The collector's maximum Java permanent generation size.

### Example

Creates a Dockerized Dynatrace Collector instance named `dtcollector` which connects to a *Dockerized Dynatrace Server* instance with named `dtserver`:

```
./run-container.sh
```

### Example

Creates a Dockerized Dynatrace Collector instance named `dtcollector-1` which connects to *AcmeCo's Dynatrace Server* instance running at `dtserver.acmeco.internal:6698`. Make sure to remove `--link dtserver` from `run-container.sh` beforehand:

```
DT_COLLECTOR_NAME=dtcollector-1 \
DT_COLLECTOR_SERVER=dtserver.acmeco.internal:6698 \
./run-container.sh
```

## Option B: Run a container via `docker-compose.yml`

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you would run an application via `docker-compose [-f docker-compose.yml] up`.

### Configuration

While running applications via Docker Compose can be convenient, configuration comes with a drawback: the appreciation of environment variables from the *compose host* in `docker-compose.yml` files has only been added in Docker 1.9. Unfortunately, this doesn't allow you to selectively override sensible defaults in these files from the environment as yet, but instead requires you to specify them each time you run `docker-compose`. Therefore, while we wait for better support from Docker, the `docker-compose.yml` file in this project comes with a static default configuration.

### Example

Creates a Dockerized Dynatrace Collector instance named `dtcollector` which connects to a *Dockerized Dynatrace Server* instance with name and link alias `dtserver`:

```
docker-compose up
```

## Build an image via `build-image.sh`

While we strongly recommend using our ready-made images on the [Docker Hub](https://hub.docker.com/r/dynatrace/collector/), you can build your own by executing `build-image.sh`.

## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Collector&dt=Dynatrace-Docker%2FDynatrace-Collector&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()