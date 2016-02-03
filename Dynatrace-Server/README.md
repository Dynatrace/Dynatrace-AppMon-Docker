![Docker Logo](https://github.com/dynaTrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Server

This project contains files for running and building the [Dynatrace Server](http://www.dynatrace.com/en/products/application-monitoring.html) in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/server/).

**Note**: the `dynatrace/server` image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

## Option 1: Run a container via `run-container.sh`

The `run-container.sh` script runs a Docker container using `docker run` and additionally shows by example how the `dynatrace/server` Docker image can be effectively configured at runtime. Please make sure to validate these settings to match your environment, as described below:

### Configuration

You can override the default configuration by providing the following *environment variables* to the script. Please examine the [Dynatrace Server Configuration](https://community.dynatrace.com/community/display/DOCDT62/Server+Configuration) page for more information on the various settings.

| Environment Variable           | Defaults                     | Description
|:-------------------------------|:-----------------------------|:-----------
| DT_SERVER_NAME                 | "dtserver"                   | A name that applies to both the server and the container instance.
| DT_SERVER_HOST_NAME            | "docker-${DT_SERVER_NAME}"   | A hostname that applies to the container instance (within Docker).
| DT_SERVER_HOST_LOG_DIR         | "/tmp/log/${DT_SERVER_NAME}" | A directory on the host the server logs shall be mapped to.
| DT_SERVER_LICENSE_KEY_FILE_URL | null                         | A URL to a Dynatrace License Key file (optional). If the variable remains unset, a license key has to be provided by connecting a Dynatrace Client to the Dynatrace Server instance.

### Examples

1) Creates a Dockerized Dynatrace Server instance named `dtserver`:

```
./run-container.sh
```

2) Creates a Dockerized Dynatrace Server instance named `dtserver` that pulls a license from `http://repo.internal/dtlicense.key`:

```
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
./run-container.sh
```
<br>

---
**TL;DR**: you can quickly spawn a Dynatrace Server instance with an anticipated set of default configurations by invoking:

```
./run-container.sh
```
---
<br>

## Option 2: Run a container via `docker-compose.yml`

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you would run an application via `docker-compose [-f docker-compose.yml] up`.

### Configuration

While running applications via Docker Compose can be convenient, configuration comes with a drawback: the appreciation of environment variables from the *compose host* in `docker-compose.yml` files has only been added in Docker 1.9. Unfortunately, this doesn't allow you to selectively override sensible defaults in these files from the environment as yet, but instead requires you to specify them each time you run `docker-compose`.

Therefore, for the moment, we have decided to limit the number of supported environment variables to those which we regard most volatile. Please examine the [Dynatrace Server Configuration](https://community.dynatrace.com/community/display/DOCDT62/Server+Configuration) page for more information on the various settings.

| Environment Variable           | Defaults | Description
|:-------------------------------|:---------|:-----------
| DT_SERVER_NAME                 | n/a      | A name that applies to both the server and the container instance.
| DT_SERVER_LICENSE_KEY_FILE_URL | n/a      | A URL to a Dynatrace License Key file (optional).

### Examples

1) Creates a Dockerized Dynatrace Server instance named `dtserver`:

```
DT_SERVER_NAME=dtserver docker-compose up
```

2) Creates a Dockerized Dynatrace Server instance named `dtserver` that pulls a license from `http://repo.internal/dtlicense.key`:

```
DT_SERVER_NAME=dtserver \
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
docker-compose up
```

<br>

---
**TL;DR**: you can quickly spawn a Dynatrace Server instance with an anticipated set of default configurations by invoking:

```
docker-compose up
```
---
<br>

### Licensing

In the examples above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). And, you don't need to have your license file hosted by a server: if you are running on a developer machine, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line via `nc -l 80 < dtlicense.key`.

## Build an image via `build-image.sh`

While we strongly recommend using our ready-made images on the [Docker Hub](https://hub.docker.com/r/dynatrace/server/), you can build your own by executing `build-image.sh`.

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
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Server&dt=Dynatrace-Docker%2FDynatrace-Server&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()