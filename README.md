![Docker Logo](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-logo.png)

# Dynatrace-Docker

The home of Dockerized components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/docker) enterprise solution. All components are available on the [Docker Hub](https://hub.docker.com/u/dynatrace/).

## What is Dynatrace?

[Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html), with its [PurePath technology](http://www.dynatrace.com/en_us/application-performance-management/products/purepath-technology.html), is the world's leading application monitoring solution - trusted by more than 7500 customers around the globe. It supports all your major technology stacks and integrates into your Continuous Delivery pipelines to allow you to build world-class, high-quality software.

## How to install Dynatrace?

You can quickly bring up an entire Dockerized Dynatrace environment by using [Docker Compose](https://docs.docker.com/compose/) with any of the provided `docker-compose.yml` files like so:

```
git clone https://github.com/Dynatrace/Dynatrace-Docker.git
cd Dynatrace-Docker
docker-compose up
```

It will install Dynatrace Server, Dynatrace Collector and Dynatrace Master Agent. Then, you can install your [Agents](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples). 


## Configuration

All required environment variables are collected in the default file ".env", that is used by all components.

Ports configuration is static and you can find it in main docker-compose.yml files. Port exposure is included in Dynatrace Server's Dockerfile file.

### Licensing

The example above leaves your Dynatrace environment without a proper license. However, you can add your license by editing .env file and put it as value for DT_SERVER_LICENSE_KEY_FILE_URL variable.

Also, you can conveniently have a license provisioned at container runtime by specifying a URL to a [Dynatrace License Key File](http://bit.ly/dttrial-docker-github) in the `DT_SERVER_LICENSE_KEY_FILE_URL` environment variable. If you don't happen to have a web server available to serve the license file to you, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line, exactly once, via `nc -l 1337 < dtlicense.key`, where `1337` is an available port on your local machine. A `sudo` may be required depending on which port you eventually decide to choose.

```
git clone https://github.com/Dynatrace/Dynatrace-Docker.git
cd Dynatrace-Docker
DT_SERVER_LICENSE_KEY_FILE_URL=http://$YOUR_IP:1337 docker-compose up
```

### Obtaining a License

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace License Key file. If you don't have a license yet, you can [obtain a Dynatrace Free Trial License here](http://bit.ly/dttrial-docker-github). However, you don't need to have your license file hosted by a server: if you can run a console, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it for you on port `80` via `sudo nc -l 80 < dtlicense.key`.

## How to Monitor your Dockerized Application?

See the following integrations for more information:

- [Dockerized Dynatrace Agent: Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/master/Dynatrace-Agent-Examples)
- [Dockerized easyTravel Application](https://github.com/Dynatrace-Innovationlab/easyTravel-Docker)

![Dockerized Application](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/dockerized-application.png)

## How to Monitor your Docker Containers?

Want to see all your Docker Metrics in one place? See the [Dynatrace Docker Monitor Plugin](https://community.dynatrace.com/community/display/DL/Docker+Monitor+Plugin) for more information.

![Docker Monitor Plugin](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-monitor-plugin.png)

## Resource Requirements

When running Docker on Windows or a Mac via the [Docker Toolbox](https://www.docker.com/products/docker-toolbox), make sure your [Docker Machine](https://docs.docker.com/machine/overview/) has sufficient resources available to run Dynatrace AppMon together with your Dockerized application:

1) Stop the Docker Machine in VirtualBox

![Power off Docker Machine](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-machine-power-off.png)

2) Give your Docker Machine at least 2 CPUs

![Configure Docker Machine CPUs](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-machine-cpu-settings.png)

3) Give your Docker Machine at least 4 GB of RAM

![Configure Docker Machine RAM](https://github.com/Dynatrace/Dynatrace-Docker/blob/images/docker-machine-mem-settings.png)

4) Finally, start your Docker Quickstart Terminal for the changes to take effect.

## Problems? Questions? Suggestions?

This offering is [Dynatrace Community Supported](https://community.dynatrace.com/community/display/DL/Support+Levels#SupportLevels-Communitysupported/NotSupportedbyDynatrace(providedbyacommunitymember)). Feel free to share any problems, questions and suggestions with your peers on the Dynatrace Community's [Application Monitoring & UEM Forum](https://answers.dynatrace.com/spaces/146/index.html).

## License

Licensed under the MIT License. See the [LICENSE](https://github.com/Dynatrace/Dynatrace-Docker/blob/master/LICENSE) file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker&dt=Dynatrace-Docker&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()
