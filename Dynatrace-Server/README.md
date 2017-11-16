![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Server

This project contains files for building and running the Dynatrace Server component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/server/).

**Note**: the `dynatrace/server` image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

## How to install Dynatrace AppMon Server?

*By default, we use root user for running containers. It is a bad practice so, if you can, you should run them as non-root. Go to the `Running Dynatrace Appmon Server as non-root` paragraph for running and configuration instructions.*

### Running Dynatrace Appmon Server as root

If you don't need to use a non-root or dedicated user to run Dynatrace Appmon Server, you can quickly bring up an entire Dockerized Dynatrace AppMon environment by using [Docker Compose](https://docs.docker.com/compose/) with the provided `docker-compose.yml` file like so :

```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git
cd Dynatrace-AppMon-Docker/Dynatrace-Server
docker-compose up -d
```
In order to browse logs produced by the service you can use:
```
docker-compose logs -f
```

### Running Dynatrace Appmon Server as non-root

For the security reasons, as Docker co-uses the host kernel, all Dynatrace Appmon services are recommended to be run as non-root user. Therefore, you should operate on dedicated user on your host machine and **set `CUID` (User ID) and `CGID` (Group ID) variables in `.env` file for your user**. By default it uses root. During image builds, user with the same ids will be created and used for running containers. 

After you change user/group id variables, you may run Dynatrace Appmon Server in two ways:
* executing `run-dtserver-as-nonroot.sh` script as dedicated user. This user should be able to run docker services (he should be added to the docker group). Example: `./run-dtserver-as-nonroot.sh -f docker-compose-debian.yml -b`, where `-b` states for docker-compose's `--build`

or
* running `docker-compose up` **after** making sure that host directory for `DT_SERVER_LOG_PATH_ON_HOST` is created and ownership is set to your dedicated user. Otherwise logs will not be available for you on host machine and service might not run due to permission denied error. 
 

### Configuration

Configuration relies on supplying docker-compose with environment variables defined in .env file. Some variables need to be passed to Dockerfile via ARG for correct building an Server image, that's way it is recommended to change variables only in .env file.

| Environment Variable          | Defaults                    | Description
|:------------------------------|:----------------------------|:-----------
| COMPOSE_PROJECT_NAME          | "dynatracedocker"           | A name of the Project. Also used for network naming.
| DT_HOME                       | "/opt/dynatrace"            | Path to dynatrace installation directory
| DT_SERVER_NAME                | "dtserver"                  | A name that applies to both the server and the container instance.
| DT_SERVER_LICENSE_KEY_FILE_URL     | N/A                    | A URL to a Dynatrace License Key file (optional). If the variable remains unset, a license key has to be provided through the Dynatrace Client.
| VERSION                       | "7.0"                       | GA version
| BUILD_VERSION                 | "7.0.0.2469"                | Build version
| CUID                          | 0                           | User ID of the user that is used in the docker container
| CGID                          | 0                           | Group ID of the user that is used in the docker container
| DT_SERVER_LOG_PATH_ON_HOST    | /tmp/log/dynatrace/servers/dtserver                           | Log path on the host

Ports are also defined in .env file based on current [Communication Connections](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-communication-connections/)

List of used ports for server:
```
APPMON_WEB_CLIENT_NONSSL_PORT=8020
APPMON_WEB_CLIENT_SSL_PORT=8021
APPMON_WEB_SSL_PORT=9911
APPMON_ONEAGENT_NONSSL_SERVER_PORT=8040
APPMON_ONEAGENT_SSL_SERVER_PORT=8041
APPMON_CLIENT_NONSSL_PORT=2021
APPMON_CLIENT_SSL_PORT=8023
APPMON_COLLECTOR_PORT=9998
APPMON_COLLECTOR_SERVER_SSL_PORT=6699
```

### Licensing

The examples above leave your Dynatrace environment without a proper license. However, you can conveniently have a license provisioned at container runtime by specifying a URL to a [Dynatrace License Key File](http://bit.ly/dttrial-docker-github) in the `DT_SERVER_LICENSE_KEY_FILE_URL` environment variable. If you don't happen to have a web server available to serve the license file to you, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line, exactly once, via `nc -l 1337 < dtlicense.key`, where `1337` is an available port on your local machine. A `sudo` may be required depending on which port you eventually decide to choose.

## Dockerized Dynatrace Components

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Server&dt=Dynatrace-Docker%2FDynatrace-Server&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
