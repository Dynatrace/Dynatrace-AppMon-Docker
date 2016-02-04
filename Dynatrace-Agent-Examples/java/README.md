![Java Logo](https://github.com/dynaTrace/Dynatrace-Docker/blob/images/java-logo.png)

# Dynatrace Agent Example: Java Process

This project contains exemplary integrations of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution with a Dockerized Java process for deep end-to-end application monitoring.

## How to install Dynatrace?

If you do not have Dynatrace installed already, you can quickly bring up an entire Dockerized Dynatrace environment by using [Docker Compose](https://docs.docker.com/compose/) with the [provided `docker-compose.yml` file](https://github.com/dynaTrace/Dynatrace-Docker/blob/master/docker-compose.yml) like so:

```
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
docker-compose up
```

**Note**: the example runs an instance of type `dynatrace/server`. This image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

### Licensing

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). However, you don't need to have your license file hosted by a server: if you can run a console, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it for you via `nc -l 80 < dtlicense.key`.

## How to instrument a Dockerized Java process?

With the Dynatrace Agent and the Dynatrace Collector running in Docker, using the `dynatrace/agent` and `dynatrace/collector` images, respectively, we can now easily instrument an application process without having to alter that process' Docker image. Instead, we manipulate its runtime environment by:

1) mounting the agent installation directory into the application process' container via `--volumes-from dtagent`.

2) linking the application process' container with the `dtagent` and `dtcollector` containers via `--link dtagent` and `--link dtcollector`, respectively. This way, we inherit the linked containers' environment variables and can, with that, quickly deduce a correct `-agentpath` declaration -- without having to know about the details.

Finally, we provide the `-agentpath` declaration to the invocation of the actual Java process ([see here for the original Dockerfile](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples/java/Dockerfile)):

<pre><code>#!/bin/bash
DT_AGENT_NAME=${JAVA_DT_AGENT_NAME:-"java-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_LIB64}=name=${DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"

echo "Starting Java - Example"
docker run --rm \
  --name dynatrace/java-example \
  <strong>--link dtagent</strong> \
  <strong>--link dtcollector</strong> \
  <strong>--volumes-from dtagent</strong> \
  dynatrace/java-example \
  sh -c "java <strong>${DT_AGENT_PATH}</strong> JavaTest"
</code></pre>

## Additional Information

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Server](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Server)
- [Dockerized Dynatrace Collector](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Collector)
- [Dockerized Dynatrace Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent) and [Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Web Server Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent) and [Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent-Examples)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the LICENSE file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent-Examples%2Fjava&dt=Dynatrace-Docker%2FDynatrace-Agent-Examples%2Fjava&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()