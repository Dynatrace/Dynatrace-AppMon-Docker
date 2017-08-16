![Docker Logo](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/blob/images/docker-logo.png)

# Dynatrace-AppMon-Docker for AppMon

The home of Dockerized components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution. All components are available on the [Docker Hub](https://hub.docker.com/u/dynatrace/).

## What is Dynatrace AppMon?

[Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html), with its [PurePath technology](http://www.dynatrace.com/en_us/application-performance-management/products/purepath-technology.html), is the world's leading application monitoring solution - trusted by more than 7500 customers around the globe. It supports all your major technology stacks and integrates into your Continuous Delivery pipelines to allow you to build world-class, high-quality software.

If you are looking for monitoring containerized applications in dynamic Docker environments, please visit [Dynatrace SaaS Docker monitoring](https://www.dynatrace.com/technologies/cloud-and-microservices/docker-monitoring).

## How to install Dynatrace AppMon?

You can quickly bring up an entire Dockerized Dynatrace AppMon environment by using [Docker Compose](https://docs.docker.com/compose/) with any of the provided `docker-compose.yml` files like so:

```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git
cd Dynatrace-AppMon-Docker
docker-compose up
```
in case of using branch:
```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git -b <BRANCH_NAME>
cd Dynatrace-AppMon-Docker
docker-compose up
```
In order to be able to work further on the same instance with Appmon running in the background use deamon option:
```
docker-compose up -d
```
Logs can be displayed by:
```
docker-compose logs -f
```

`docker-compose up` will install Dynatrace Server, Dynatrace Collector and Dynatrace Master Agent. Then, you can install your [Agents](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/7.0_GA/Dynatrace-Agent-Examples).


## How to build images?

In order to build slim version:
```
docker-compose build
```
In order to build full version:
```
docker-compose -f docker-compose-debian.yml build
```

## How to run containers?

[Docker Compose](https://docs.docker.com/compose/) is a tool for defining and running multi-container applications, where an application's services are configured in `docker-compose.yml` files. Typically, you want to use:

```
docker-compose up -d
```
or
```
docker-compose up -d --build
```

### Other commands:

*NOTE*:
`[]` - is optional
`-f` - uses alternative docker-compose.yml file
`-d` - run as deamon

If you want to run slim version(s) you can skip -f option.

In order to create container(s)
```
docker-compose create
docker-compose -f docker-compose-debian.yml create
```
In order to run already created container(s)
```
docker-compose start
docker-compose -f docker-compose-debian.yml start
```
In order to build unbuilt image(s), (re)create container(s) and run them in deamon mode
```
docker-compose up -d
docker-compose -f docker-compose-debian.yml up -d
```
In order to rebuild image(s), (re)create container(s) and run them in deamon mode
```
docker-compose up -d --build
docker-compose -f docker-compose-debian.yml up -d --build
```
If you run as deamon and you want to see logs, you can follow each service logs using
```
docker-compose logs -f
```


## Configuration

Configuration relies on supplying docker-compose with environment variables defined in .env file. Some variables need to be passed to Dockerfile via ARG for correct building an Server image, that's way it is recommended to change variables only from .env file.

Ports can be also configured in .env file. By default it uses values from [Communication Connections Documentation](https://community-staging.dynalabs.io/support/doc/appmon/installation/set-up-communication-connections/).

Please see each component's README file for more specific details about configuration.

### Licensing

The example above leaves your Dynatrace AppMon environment without a proper license. However, you can add your license by editing .env file and put it as value for DT_SERVER_LICENSE_KEY_FILE_URL variable.

Also, you can conveniently have a license provisioned at container runtime by specifying a URL to a [Dynatrace License Key File](http://bit.ly/dttrial-docker-github) in the `DT_SERVER_LICENSE_KEY_FILE_URL` environment variable. If you don't happen to have a web server available to serve the license file to you, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it from your command line, exactly once, via `nc -l 1337 < dtlicense.key`, where `1337` is an available port on your local machine. A `sudo` may be required depending on which port you eventually decide to choose.

```
git clone https://github.com/Dynatrace/Dynatrace-Docker.git
cd Dynatrace-Docker
DT_SERVER_LICENSE_KEY_FILE_URL=http://$YOUR_IP:1337 docker-compose up
```

### Obtaining a License

In the example above, you have to let `DT_SERVER_LICENSE_KEY_FILE_URL` point to a valid Dynatrace AppMon License Key file. If you don't have a license yet, you can [obtain a Dynatrace AppMon Free Trial License here](http://bit.ly/dttrial-docker-github). However, you don't need to have your license file hosted by a server: if you can run a console, [Netcat](https://en.wikipedia.org/wiki/Netcat) can conveniently serve it for you on port `80` via `sudo nc -l 80 < dtlicense.key`.

## How to Monitor your Dockerized Application?

See the following integrations for more information:

- [Dockerized AppMon Agent: Examples](https://github.com/Dynatrace/Dynatrace-Docker/tree/7.0_GA/Dynatrace-Agent-Examples)
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
