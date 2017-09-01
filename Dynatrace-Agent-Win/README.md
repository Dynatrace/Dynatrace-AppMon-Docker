![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Agent

This project contains files for building and running the Dynatrace Agent component of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution for deep end-to-end application monitoring in Docker. Ready-made images are available on the [Docker Hub](https://hub.docker.com/r/dynatrace/agent/). Please refer to the [Dynatrace Agent Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent-Examples) project for exemplary integrations into Dockerized application processes.

## Build image

In order to build slim version:
```
docker-compose build
```

## Run a container

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you want to use:

```
docker-compose up -d
```
or
```
docker-compose up -d --build
```

### Configuration

Configuration relies on supplying docker-compose with environment variables defined in .env file. Some variables need to be passed to Dockerfile via ARG for correct building an Server image, that's way it is recommended to change variables only in .env file.

| Environment Variable  | Defaults                    | Description
|:----------------------|:------------------------------------------------|:-----------
| COMPOSE_PROJECT_NAME  | "dynatracedocker"           | A name of the Project. Also used for network naming.
| DT_HOME               | "c:\dynatrace"            | Path to dynatrace installation directory
| DT_AGENT_NAME         | "dtagent"                   | A name that applies to both the agent and the container instance.
| DT_COLLECTOR_NAME     | "dtcollector"               | A name that applies to both the collector and the container instance.
| DT_VERSION            | "7.0"                       | GA version
| DT_BUILD_VERSION      | "7.0.0.2469"                | Build version
| DT_ENABLE_AGENT       | "True"                      | Enable/Disable agent on container.



## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent&dt=Dynatrace-Docker%2FDynatrace-Agent&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
