![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Agent

This project contains files for building and running the Dynatrace Agent component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/agent/). Please refer to the [Dynatrace Agent Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent-Examples) project for exemplary integrations into Dockerized application processes.

<br>

---
**TL;DR**: you can quickly spawn a `dynatrace/agent` instance with an anticipated default configuration by invoking:

```
docker-compose up
```
---
<br>

## Option A: Run a container via `run-container.sh`

The `run-container.sh` script runs a Docker container using `docker run` and additionally shows by example how the `dynatrace/agent` Docker image can be effectively configured at runtime. Please make sure to validate these settings to match your environment, as described below:

### Configuration

You can override the default configuration by providing the following *environment variables* to the script:

| Environment Variable  | Defaults                    | Description
|:----------------------|:----------------------------|:-----------
| DT_AGENT_NAME         | "dtagent"                   | A name that applies to both the agent and the container instance.
| DT_AGENT_HOST_LOG_DIR | "/tmp/log/${DT_AGENT_NAME}" | A directory on the host the agent logs shall be mapped to.
| DT_AGENT_COLLECTOR    | n/a                         | An optional "host:port" combination to a [Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Collector). A Dynatrace Collector running in Docker will be auto-discovered if the application container which has the agent applied links to the collector container via `--link dtcollector`.

### Example

Creates a Dockerized Dynatrace Agent instance named `dtagent`:

```
./run-container.sh
```

### Example

Creates a Dockerized Dynatrace Agent instance named `java-agent`:

```
DT_AGENT_NAME=java-agent ./run-container.sh
```

## Option B: Run a container via `docker-compose.yml`

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you would run an application via `docker-compose [-f docker-compose.yml] up`.

### Configuration

While running applications via Docker Compose can be convenient, configuration comes with a drawback: the appreciation of environment variables from the *compose host* in `docker-compose.yml` files has only been added in Docker 1.9. Unfortunately, this doesn't allow you to selectively override sensible defaults in these files from the environment as yet, but instead requires you to specify them each time you run `docker-compose`. Therefore, while we wait for better support from Docker, the `docker-compose.yml` file in this project comes with a static default configuration.

### Example

Creates a Dockerized Dynatrace Agent instance named `dtagent`:

```
docker-compose up
```

## Build an image via `build-image.sh`

While we strongly recommend using our ready-made images on the [Docker Hub](https://hub.docker.com/r/dynatrace/agent/), you can build your own by executing `build-image.sh`.

## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/6.3/Dynatrace-Agent/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent&dt=Dynatrace-Docker%2FDynatrace-Agent&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()