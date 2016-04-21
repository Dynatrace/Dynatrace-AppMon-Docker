![Java Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/java-logo.png)

# Dynatrace Agent Example: Java Process

This project contains exemplary integrations of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution with a Dockerized Java process for deep end-to-end application monitoring.

## How to install Dynatrace?

You can quickly bring up an entire Dockerized Dynatrace environment by using [Docker Compose](https://docs.docker.com/compose/) with the [provided `docker-compose.yml` file](https://github.com/Dynatrace/Dynatrace-Docker/blob/6.3/docker-compose.yml) like so:

```
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
docker-compose up
```

**Note**: the example runs an instance of type `dynatrace/server`. This image has been designed to run in low-traffic, resource-constrained **demo and trial environments**. Dynatrace does not support its use in production or pre-production grade environments of any kind.

### Licensing

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). However, you don't need to have your license file hosted by a server: if you can run a console, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it for you on port `80` via `sudo nc -l 80 < dtlicense.key`.

## How to instrument a Dockerized Java process?

With the Dockerized Dynatrace environment running, we can now easily instrument an application process without having to alter that process' Docker image. Here is what an examplary integration in `run-container.sh` looks like:

<pre><code>#!/bin/bash
DT_AGENT_NAME=${JAVA_DT_AGENT_NAME:-"java-agent"}
DT_AGENT_PATH="-agentpath:\${DTAGENT_ENV_AGENT_LIB64}=name=${DT_AGENT_NAME},collector=\${DTCOLLECTOR_ENV_HOST_NAME}"

echo "Starting Java - Example"
docker run --rm \
  --name dynatrace/java-example \
  <strong>--volumes-from dtagent</strong> \               # <strong>1)</strong>
  <strong>--link dtcollector</strong> \                   # <strong>2)</strong>
  <strong>--link dtagent</strong> \                       # <strong>2)</strong>
  dynatrace/java-example \
  sh -c "java <strong>${DT_AGENT_PATH}</strong> JavaTest" # <strong>3)</strong>
</code></pre>

### Behind the Scenes

1) We mount the agent installation directory from the `dtagent` container into the application process' container via `--volumes-from dtagent`.

2) **Convenience**: We link the application process' container against the `dtcollector` and `dtagent` containers via `--link dtcollector` and `--link dtagent`, respectively. This way, we inherit the other containers' environment variables `DTCOLLECTOR_ENV_HOST_NAME` and `DTAGENT_ENV_AGENT_LIB64` and can thus quickly deduce an `-agentpath` declaration without having to know much about the environment.

3) We invoke the actual application process ([see here for the original Dockerfile](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent-Examples/java/Dockerfile)).

## Additional Information

See the following Dockerized Dynatrace components and examples for more information:

- [Dockerized Dynatrace Agent](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent) and [Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Agent-Examples)
- [Dockerized Dynatrace Collector](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Collector)
- [Dockerized Dynatrace Server](https://github.com/Dynatrace/Dynatrace-Docker/tree/6.3/Dynatrace-Server)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/6.3/Dynatrace-Agent-Examples/java/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Agent-Examples%2Fjava&dt=Dynatrace-Docker%2FDynatrace-Agent-Examples%2Fjava&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()