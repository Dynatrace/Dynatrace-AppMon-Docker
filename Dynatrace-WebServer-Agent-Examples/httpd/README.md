# Dynatrace WebServer Agent Example: Apache HTTPD

This project contains exemplary integrations of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution with a [Dockerized Apache HTTPD](https://hub.docker.com/_/httpd/) process for deep end-to-end application monitoring.

**Note**: the Dynatrace Web Server Agent (master agent) process inside `dynatrace/wsagent` is tightly coupled to the web server modules (slave agents) which are loaded into web server processes. Due to high latency sensitivity, these counterparts must always run on the same host.

## Installing Dynatrace

If you do not have Dynatrace installed already, you could quickly bring up a Dockerized Dynatrace installation by using the enclosed [Docker Compose](https://docs.docker.com/compose/) file `docker-compose-dynatrace.yml` like so:

```
DT_COLLECTOR_NAME=dtcollector \
DT_SERVER_NAME=dtserver \
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
DT_WSAGENT_NAME=dtwsagent \
docker-compose -f docker-compose-dynatrace.yml up
```

The example runs an instance of type `dynatrace/server`. This image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

### Licensing

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial). And, you don't need to have your license file hosted by a server: if you are running on a developer machine, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line via `nc -l 80 < dtlicense.key`.

## Instrumenting a Dockerized Apache HTTPD Process

With the Dynatrace Web Server Agent running in Docker, using the `dynatrace/wsagent` image, we can now easily instrument a web server process without having to alter that process' Docker image. Instead, we manipulate its runtime environment by:

1) mounting the agent installation directory into the web server process' container via `--volumes-from dtwsagent`. This allows the master agent to share configuration data with its slave agents.

2) linking the web server process' container with the `dtwsagent` container via `--link dtwsagent`. This way, we inherit the linked container's environment variables and can, with that, quickly deduce a correct `LoadModule` declaration -- without having to know about the details.

3) sharing the `dtwsagent`'s IPC namespace via `--ipc container:dtwsagent`. This allows the master and slaves to shared a shared memory segment despite being separated into two distinct containers.

4) attaching to the `dtwsagent` by invoking `attach-to-wsagent-master.sh`. This enables the master and slaves to communicate via UDP. Additionally, we want to make sure that the script executes in the background only after the web server process has started (hence the speculative `sleep 1` below).

Finally, we place the `LoadModule` declaration inside Apache HTTPD's `httpd.conf` and invoke the actual web server process ([see here for the original Dockerfile](https://github.com/docker-library/httpd/blob/1f1f7d39d5fe5aebeedea6872786b4e3ce0ebcc9/2.4/Dockerfile)):

<pre><code>#!/bin/bash
HTTPD_LOAD_MODULE="dtagent_module \${DTWSAGENT_ENV_DT_WSAGENT_LIB64}"

echo "Starting Apache HTTPD - Example"
docker run --rm \
  --name httpd-example \
  <strong>--link dtwsagent</strong> \
  <strong>--volumes-from dtwsagent</strong> \
  <strong>--ipc container:dtwsagent</strong> \
  --publish-all \
  httpd \
  sh -c "(<strong>sleep 1 && \${DTWSAGENT_ENV_SOCAT_HOME}/attach-to-wsagent-master.sh &</strong>) && \
         (<strong>echo LoadModule ${HTTPD_LOAD_MODULE} >> conf/httpd.conf</strong>) && \
         httpd-foreground"
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