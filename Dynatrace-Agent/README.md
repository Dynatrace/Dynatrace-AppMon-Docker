![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Agent

This project contains files for building and running the Dynatrace Master Agent component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/agent/). Please refer to the [Dynatrace Agent Examples](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/master/Dynatrace-Agent-Examples) project for exemplary integrations into Dockerized application processes.

## How to install Dynatrace AppMon Master Agent?

*By default, we use root user for running containers. It is a bad practice so, if you can, you should run them as non-root. Go to the `Running Dynatrace Appmon Master Agent as non-root` paragraph for running and configuration instructions.*

### Running Dynatrace Appmon Master Agent as root

If you don't need to use a non-root or dedicated user to run Dynatrace Appmon Master Agent, you can quickly bring up an entire Dockerized Dynatrace AppMon environment by using [Docker Compose](https://docs.docker.com/compose/) with the provided `docker-compose.yml` file like so :

```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git
cd Dynatrace-AppMon-Docker/Dynatrace-Agent
docker-compose up -d
```
In order to browse logs produced by the service you can use:
```
docker-compose logs -f
```

### Running Dynatrace Appmon Master Agent as non-root

For the security reasons, as Docker co-uses the host kernel, all Dynatrace Appmon services are recommended to be run as non-root user. Therefore, you should operate on dedicated user on your host machine and **set `CUID` (User ID) and `CGID` (Group ID) variables in `.env` file for your user**. By default it uses root. During image builds, user with the same ids will be created and used for running containers. 

After you change user/group id variables, you may run Dynatrace Appmon Master Agent in two ways:
* executing `run-dtagent-as-nonroot.sh` script as dedicated user. This user should be able to run docker services (he should be added to the docker group). Example: `./run-dtagent-as-nonroot.sh -f docker-compose-debian.yml -b`, where `-b` states for docker-compose's `--build`

or
* running `docker-compose up` **after** making sure that host directory for `DT_AGENT_LOG_PATH_ON_HOST` is created and ownership is set to your dedicated user. Otherwise logs will not be available for you on host machine and service might not run due to permission denied error. 


### Configuration

Configuration relies on supplying docker-compose with environment variables defined in .env file. Some variables need to be passed to Dockerfile via ARG for correct building an Server image, that's way it is recommended to change variables only in .env file.

| Environment Variable  | Defaults                    | Description
|:----------------------|:------------------------------------------------|:-----------
| COMPOSE_PROJECT_NAME  | "dynatracedocker"           | A name of the Project. Also used for network naming.
| DT_HOME               | "/opt/dynatrace"            | Path to dynatrace installation directory
| DT_AGENT_NAME         | "dtagent"                   | A name that applies to both the agent and the container instance.
| DT_COLLECTOR_NAME     | "dtcollector"               | A name that applies to both the collector and the container instance.
| AGENT_LIB32           | "/agent/lib/libdtagent.so"  | Relative path to 32 bit libdtagent.so
| AGENT_LIB64           | "/agent/lib64/libdtagent.so"       | Relative path to 64 bit libdtagent.so
| NODE_AGENT_LIB32      | "/agent/bin/linux-x86-32/liboneagentloader.so"   | Relative path to 32 bit liboneagentloader.so
| NODE_AGENT_LIB64      | "/agent/bin/linux-x86-64/liboneagentloader.so"   | Relative path to 64 bit liboneagentloader.so
| WSAGENT_BIN64         | "/agent/lib64/dtwsagent"    | Relative path to dtwsagent
| WSAGENT_INI           | "/agent/conf/dtwsagent.ini" | Relative path to dtwsagent.ini
| VERSION               | "7.0"                       | GA version
| BUILD_VERSION         | "7.0.0.2469"                | Build version
| CUID                          | 0                           | User ID of the user that is used in the docker container
| CGID                          | 0                           | Group ID of the user that is used in the docker container
| DT_AGENT_LOG_PATH_ON_HOST    | /tmp/log/dynatrace/agents/dtagent                           | Log path on the host


**Master Agent** (`dtagent`) service only prepares required libraries and installation scripts for triggering agents. Running and configuring agents is manual action done by the user. Examples are [here](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/master/Dynatrace-Agent-Examples).
If you are not familiar with Appmon Agents concept, please read: [Agents Overview](https://www.dynatrace.com/support/doc/appmon/application-monitoring/agents/), [Agents Installation](https://www.dynatrace.com/support/doc/appmon/installation/install-agents/), [Agents Configuration](https://www.dynatrace.com/support/doc/appmon/installation/set-up-agents/)


## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent&dt=Dynatrace-Docker%2FDynatrace-Agent&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
