![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Server

This project contains files for building and running the Dynatrace Server component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/server/).

**Note**: the `dynatrace/server` image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

<br>

---
**TL;DR**: you can quickly spawn a `dynatrace/server` instance with an anticipated default configuration by invoking:

```
docker-compose up
```
---
<br>

## Option A: Run a container via `run-container.sh`

The `run-container.sh` script runs a Docker container using `docker run` and additionally shows by example how the `dynatrace/server` Docker image can be effectively configured at runtime. Please make sure to validate these settings to match your environment, as described below:

### Configuration

You can override the default configuration by providing the following *environment variables* to the script. Please examine the [Dynatrace Server Configuration](https://community.dynatrace.com/community/display/DOCDT65/Server+Configuration) page for more information on the various settings.

| Environment Variable           | Defaults                     | Description
|:-------------------------------|:-----------------------------|:-----------
| DT_SERVER_NAME                 | "dtserver"                   | A name that applies to both the server and the container instance.
| DT_SERVER_HOST_LOG_DIR         | "/tmp/log/${DT_SERVER_NAME}" | A directory on the host the server logs shall be mapped to.
| DT_SERVER_HOST_NAME            | "docker-${DT_SERVER_NAME}"   | A hostname that applies to the container instance (within Docker).
| DT_SERVER_LICENSE_KEY_FILE_URL | n/a                          | A URL to a Dynatrace License Key file (optional). If the variable remains unset, a license key has to be provided through the Dynatrace Client.

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

## Option B: Run a container via `docker-compose.yml`

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you would run an application via `docker-compose [-f docker-compose.yml] up`.

### Configuration

While running applications via Docker Compose can be convenient, configuration comes with a drawback: the appreciation of environment variables from the *compose host* in `docker-compose.yml` files has only been added in Docker 1.9. Unfortunately, this doesn't allow you to selectively override sensible defaults in these files from the environment as yet, but instead requires you to specify them each time you run `docker-compose`. Therefore, while we wait for better support from Docker, the number of supported environment variables is reduced to a minimum.

| Environment Variable           | Defaults | Description
|:-------------------------------|:---------|:-----------
| DT_SERVER_LICENSE_KEY_FILE_URL | n/a      | A URL to a Dynatrace License Key file (optional). If the variable remains unset, a license key has to be provided through the Dynatrace Client.

### Examples

Creates a Dockerized Dynatrace Server instance named `dtserver`:

```
docker-compose up
```

### Licensing

The examples above leave your Dynatrace environment without a proper license. However, you can conveniently have a license provisioned at container runtime by specifying a URL to a [Dynatrace License Key File](http://bit.ly/dttrial-docker-github) in the `DT_SERVER_LICENSE_KEY_FILE_URL` environment variable. If you don't happen to have a web server available to serve the license file to you, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line, exactly once, via `nc -l 1337 < dtlicense.key`, where `1337` is an available port on your local machine. A `sudo` may be required depending on which port you eventually decide to choose.

## Build an image via `build-image.sh`

While we strongly recommend using our ready-made images on the [Docker Hub](https://hub.docker.com/r/dynatrace/server/), you can build your own by executing `build-image.sh`.

## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Server&dt=Dynatrace-Docker%2FDynatrace-Server&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()