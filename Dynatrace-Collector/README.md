![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Collector

This project contains files for building and running the Dynatrace Collector component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/collector/).

## How to install Dynatrace AppMon Collector?

*By default, we use root user for running containers. It is a bad practice so, if you can, you should run them as non-root. Go to the `Running Dynatrace Appmon Collector as non-root` paragraph for running and configuration instructions.*

### Running Dynatrace Appmon Collector as root

If you don't need to use a non-root or dedicated user to run Dynatrace Appmon Collector, you can quickly bring up an entire Dockerized Dynatrace AppMon environment by using [Docker Compose](https://docs.docker.com/compose/) with the provided `docker-compose.yml` file like so :

```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git
cd Dynatrace-AppMon-Docker/Dynatrace-Collector
docker-compose up -d
```
In order to browse logs produced by the service you can use:
```
docker-compose logs -f
```

### Running Dynatrace Appmon Collector as non-root

For the security reasons, as Docker co-uses the host kernel, all Dynatrace Appmon services are recommended to be run as non-root user. Therefore, you should operate on dedicated user on your host machine and **set `CUID` (User ID) and `CGID` (Group ID) variables in `.env` file for your user**. By default it uses root. During image builds, user with the same ids will be created and used for running containers. 

After you change user/group id variables, you may run Dynatrace Appmon Collector in two ways:
* executing `run-dtcollector-as-nonroot.sh` script as dedicated user. This user should be able to run docker services (he should be added to the docker group). Example: `./run-dtcollector-as-nonroot.sh -f docker-compose-debian.yml -b`, where `-b` states for docker-compose's `--build`

or
* running `docker-compose up` **after** making sure that host directory for `DT_COLLECTOR_LOG_PATH_ON_HOST` is created and ownership is set to your dedicated user. Otherwise logs will not be available for you on host machine and service might not run due to permission denied error. 
 
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
| CUID                          | 0                           | User ID of the user that is used in the docker container
| CGID                          | 0                           | Group ID of the user that is used in the docker container
| DT_COLLECTOR_LOG_PATH_ON_HOST    | /tmp/log/dynatrace/collectors/dtcollector                           | Log path on the host


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


## Running container with docker run

You can reuse .env file to run containter directly using docker run command. 
DT_SERVER_NAME and DT_COLLECTOR_SERVER should point to your AppMon server.

```
export DT_COLLECTOR_NAME=dt-collector-docker1

docker run -d --name ${DT_COLLECTOR_NAME} \
  --env DT_COLLECTOR_NAME=${DT_COLLECTOR_NAME} \
  --env-file .env \
  --hostname dt-collector-docker.cloud \
  -p 9998:9998 \
  --volume /opt/dynatrace/${DT_COLLECTOR_NAME}/log:/opt/dynatrace/log/collector/ \
  --volume /opt/dynatrace/${DT_COLLECTOR_NAME}/instances:/opt/dynatrace/collector/instances/${DT_COLLECTOR_NAME} \
  --publish-all \
   dynatrace/collector:7.0 

```

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
