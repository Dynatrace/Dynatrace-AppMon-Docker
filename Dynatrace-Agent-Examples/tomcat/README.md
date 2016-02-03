![Apache Tomcat Logo](https://github.com/dynaTrace/Dynatrace-Docker/blob/images/apache-tomcat-logo.png)

# Dynatrace Agent Example: Apache Tomcat

This project contains exemplary integrations of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution with a [Dockerized Apache Tomcat](https://hub.docker.com/_/tomcat/) process for deep end-to-end application monitoring.

## Installing Dynatrace

If you do not have Dynatrace installed already, you could quickly bring up a Dockerized Dynatrace installation by using the enclosed [Docker Compose](https://docs.docker.com/compose/) file `docker-compose-dynatrace.yml` like so:

```
DT_AGENT_NAME=dtagent \
DT_COLLECTOR_NAME=dtcollector \
DT_SERVER_NAME=dtserver \
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
docker-compose -f docker-compose-dynatrace.yml up
```

The example runs an instance of type `dynatrace/server`. This image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

### Licensing

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). And, you don't need to have your license file hosted by a server: if you are running on a developer machine, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line via `nc -l 80 < dtlicense.key`.

## Instrumenting a Dockerized Apache Tomcat Process

With the Dynatrace Agent and the Dynatrace Collector running in Docker, using the `dynatrace/agent` and `dynatrace/collector` images, respectively, we can now easily instrument an application process without having to alter that process' Docker image. Instead, we manipulate its runtime environment by:

1) mounting the agent installation directory into the application process' container via `--volumes-from dtagent`.

2) linking the application process' container with the `dtagent` and `dtcollector` containers via `--link dtagent` and `--link dtcollector`, respectively. This way, we inherit the linked containers' environment variables and can, with that, quickly deduce a correct `-agentpath` declaration -- without having to know about the details.

Finally, we override Tomcat's `CATALINA_OPTS` before we invoke the actual application process ([see here for the original Dockerfile](https://github.com/docker-library/tomcat/blob/e36c4044b7ece1361f124aaf3560c2efd888b62f/8-jre8/Dockerfile)):

<pre><code>#!/bin/bash
DT_AGENT_NAME=${TOMCAT_DT_AGENT_NAME:-"tomcat-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_LIB64}=name=${TOMCAT_DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"

echo "Starting Apache Tomcat - Example"
docker run --rm \
  --name tomcat-example \
  <strong>--link dtagent</strong> \
  <strong>--link dtcollector</strong> \
  <strong>--volumes-from dtagent</strong> \
  --publish-all \
  tomcat \
  sh -c "<strong>CATALINA_OPTS=${DT_AGENT_PATH}</strong> catalina.sh run"
</code></pre>

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
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent-Examples%2Ftomcat&dt=Dynatrace-Docker%2FDynatrace-Docker%2FDynatrace-Agent-Examples%2Ftomcat&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()