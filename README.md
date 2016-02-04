![Docker Logo](https://github.com/dynaTrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Docker

The home of Dockerized components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution. All components are available on the [Docker Hub](https://hub.docker.com/u/dynatrace/).

## How to install Dynatrace?

You can quickly bring up an entire Dockerized Dynatrace environment by using [Docker Compose](https://docs.docker.com/compose/) with the provided `docker-compose.yml` file like so:

```
DT_SERVER_LICENSE_KEY_FILE_URL=http://repo.internal/dtlicense.key \
docker-compose up
```

See the following Dockerized Dynatrace components for more information:

- [Dockerized Dynatrace Server](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Server)
- [Dockerized Dynatrace Collector](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Collector)
- [Dockerized Dynatrace Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent)
- [Dockerized Dynatrace Web Server Agent](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent)

### Licensing

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). However, you don't need to have your license file hosted by a server: if you can run a console, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it for you on port `80` via `sudo nc -l 80 < dtlicense.key`.

## How to Monitor your Dockerized Application?

See the following integration examples for more information:

- [Dynatrace Agent: Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dynatrace Web Server Agent: Examples](https://github.com/dynaTrace/Dynatrace-Docker/tree/master/Dynatrace-WebServer-Agent-Examples)

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the LICENSE file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker&dt=Dynatrace-Docker&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
