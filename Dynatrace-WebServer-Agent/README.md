# Dynatrace-WebServer-Agent

This project contains files for running and building the [Dynatrace WebServer Agent](http://www.dynatrace.com/en/products/application-monitoring.html) (master agent) in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/wsagent/). Please refer to the [Dynatrace Web Server Agent Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent-Examples) project for exemplary integrations into Dockerized web server processes.

**Note**: the Dynatrace Web Server Agent (master agent) process inside `dynatrace/wsagent` is tightly coupled to the web server modules (slave agents) which are loaded into web server processes. Due to high latency sensitivity, these counterparts must always run on the same host.

## Option 1: Run a container via `run-container.sh`

The `run-container.sh` script runs a Docker container using `docker run` and additionally shows by example how the `dynatrace/wsagent` Docker image can be effectively configured at runtime. Please make sure to validate these settings to match your environment, as described below:

### Configuration

You can override the default configuration by providing the following *environment variables* to the script. Please examine the [Dynatrace Web Server Agent Configuration](https://community.dynatrace.com/community/display/DOCDT62/Web+Server+Agent+Configuration) page for more information on the various settings.

| Environment Variable    | Defaults                      | Description
|:------------------------|:------------------------------|:-----------
| DT_WSAGENT_NAME         | "dtwsagent"                   | A name that applies to both the agent and the container instance.
| DT_WSAGENT_HOST_NAME    | "docker-${DT_WSAGENT_NAME}"   | A hostname that applies to the container instance (within Docker).
| DT_WSAGENT_HOST_LOG_DIR | "/tmp/log/${DT_WSAGENT_NAME}" | A directory on the host the agent logs shall be mapped to.
| DT_WSAGENT_LOG_LEVEL    | "info"                        | The log level to be maintained by the agent process.
| DT_WSAGENT_COLLECTOR    | null                          | The "hostname:port" to a collector the agent shall connect to. Auto-discovered if the agent is linked to an instance of `dynatrace/collector` with alias `dtcollector.

### Example

Creates a Dockerized Dynatrace WebServer Agent instance named `dtwsagent` which connects to a *Dockerized Dynatrace Collector* instance with name and link alias `dtcollector`:

```
./run-container.sh
```

### Example

Creates a Dockerized Dynatrace WebServer Agent instance named `dtwsagent-1` which connects to *AcmeCo's Dynatrace Collector* instance running at `dtcollector.acmeco.internal:9998`. Make sure to remove `--link dtcollector` from `run-container.sh` beforehand:

```
DT_WSAGENT_NAME=dtwsagent-1 \
DT_WSAGENT_COLLECTOR=dtcollector.acmeco.internal:9998 \
./run-container.sh
```
<br>

---
**TL;DR**: you can quickly spawn a Dynatrace WebServer Agent instance with an anticipated set of default configurations by invoking:

```
./run-container.sh
```
---
<br>

## Option 2: Run a container via `docker-compose.yml`

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you would run an application via `docker-compose [-f docker-compose.yml] up`.

### Configuration

While running applications via Docker Compose can be convenient, configuration comes with a drawback: the appreciation of environment variables from the *compose host* in `docker-compose.yml` files has only been added in Docker 1.9. Unfortunately, this doesn't allow you to selectively override sensible defaults in these files from the environment as yet, but instead requires you to specify them each time you run `docker-compose`.

Therefore, for the moment, we have decided to limit the number of supported environment variables to those which we regard most volatile. Please examine the [Dynatrace Web Server Agent Configuration](https://community.dynatrace.com/community/display/DOCDT62/Web+Server+Agent+Configuration) page for more information on the various settings.

| Environment Variable | Defaults | Description
|:---------------------|:---------|:-----------
| DT_WSAGENT_NAME      | n/a      | A name that applies to both the agent and the container instance.

### Example

Creates a Dockerized Dynatrace WebServer Agent instance named `dtwsagent` which connects to a *Dockerized Dynatrace Collector* instance with name and link alias `dtcollector`:

```
DT_WSAGENT_NAME=dtwsagent docker-compose up
```

### Example

Creates a Dockerized Dynatrace WebServer Agent instance named `dtwsagent-1` which connects to *AcmeCo's Dynatrace Server* instance running at `dtcollector.acmeco.internal:9998`. Make sure to add a proper `DT_WSAGENT_COLLECTOR` to the `environment` section and remove the `external_links` section from `docker-compose.yml` beforehand:

```
DT_WSAGENT_COLLECTOR=dtwsagent-1 docker-compose up
```
<br>

---
**TL;DR**: you can quickly spawn a Dynatrace WebServer Agent instance with an anticipated set of default configurations by invoking:

```
DT_WSAGENT_NAME=dtwsagent docker-compose up
```
---
<br>

## Build an image via `build-image.sh`

While we strongly recommend using our ready-made images on the [Docker Hub](https://hub.docker.com/r/dynatrace/wsagent/), you can build your own by executing `build-image.sh`.

## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Server](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Server)
- [Dockerized Dynatrace Collector](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Collector)
- [Dockerized Dynatrace Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent) and [Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Web Server Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent) and [Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent-Examples)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the LICENSE file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-WebServer-Agent&dt=Dynatrace-Docker%2FDynatrace-WebServer-Agent&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()