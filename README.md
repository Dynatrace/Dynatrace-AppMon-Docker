![Docker Logo](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/blob/images/docker-logo.png)

# Dynatrace-AppMon-Docker for AppMon

The home of Dockerized components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) enterprise solution. All components are available on the [Docker Hub](https://hub.docker.com/u/dynatrace/).

## What is Dynatrace AppMon?

[Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html), with its [PurePath technology](http://www.dynatrace.com/en_us/application-performance-management/products/purepath-technology.html), is the world's leading application monitoring solution - trusted by more than 7500 customers around the globe. It supports all your major technology stacks and integrates into your Continuous Delivery pipelines to allow you to build world-class, high-quality software.

If you are looking for monitoring containerized applications in dynamic Docker environments, please visit [Dynatrace SaaS Docker monitoring](https://www.dynatrace.com/technologies/cloud-and-microservices/docker-monitoring).

## How to install Dynatrace AppMon?

*By default, we use root user for running containers. It is a bad practice so, if you can, you should run them as non-root. Go to the `Running Dynatrace Appmon containers as non-root` paragraph for running and configuration instructions.*

### Running Dynatrace Appmon services as root

If you don't need to use a non-root or dedicated user to run Dynatrace Appmon docker containers, you can quickly bring up an entire Dockerized Dynatrace AppMon environment by using [Docker Compose](https://docs.docker.com/compose/) with any of the provided `docker-compose.yml` files  like so :

```
git clone https://github.com/Dynatrace/Dynatrace-AppMon-Docker.git
cd Dynatrace-AppMon-Docker
docker-compose up -d
```
This will install and run all Appmon services like Server, Collector and Master Agent in daemon mode in single containers joined the same subnetwork. Then, you can install your [Agents](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/master/Dynatrace-Agent-Examples) (see Configuration part for further details).
In order to browse logs produced by these services you can use:
```
docker-compose logs -f
```

### Running Dynatrace Appmon services as non-root

For the security reasons, as Docker co-uses the host kernel, all Dynatrace Appmon services are recommended to be run as non-root user. Therefore, you should operate on dedicated user on your host machine and **set `CUID` (User ID) and `CGID` (Group ID) variables in `.env` file for your user**. By default it uses root. During image builds, user with the same ids will be created and used for running containers. 

After you change user/group id variables, you may run Dynatrace Appmon in two ways:
* executing `run-as-nonroot.sh` script as dedicated user. This user should be able to run docker services (he should be added to the docker group). Example: `./run-as-nonroot.sh -f docker-compose-debian.yml -b`, where `-b` states for docker-compose's `--build` 




or
* running `docker-compose up` **after** making sure that host directories for `DT_SERVER_LOG_PATH_ON_HOST`, `DT_COLLECTOR_LOG_PATH_ON_HOST` and `DT_AGENT_LOG_PATH_ON_HOST` are created and ownerships are set to your dedicated user. Otherwise logs will not be available for you on host machine and/or some service might not run due to permission denied error. 
  
#### Configuration

Configuration relies on supplying `docker-compose` with environment variables defined in `.env` file. Some .env files variables need to be passed to `Dockerfile` via `ARG` for correct building component images, that's way it is recommended to change variables only from `.env` file.

**Ports** can be also configured in .env file. By default it uses values from [Communication Connections Documentation](https://www.dynatrace.com/support/doc/appmon/installation/set-up-communication-connections/).

**Master Agent** (`dtagent`) service only prepares required libraries and installation scripts for triggering agents. Running and configuring agents is manual action done by the user. Examples are [here](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/master/Dynatrace-Agent-Examples).
If you are not familiar with Appmon Agents concept, please read: [Agents Overview](https://www.dynatrace.com/support/doc/appmon/application-monitoring/agents/), [Agents Installation](https://www.dynatrace.com/support/doc/appmon/installation/install-agents/), [Agents Configuration](https://www.dynatrace.com/support/doc/appmon/installation/set-up-agents/)

If you *don't* want to validate CA certificate for curl commands, you may want to initialize `CURL_INSECURE` variable to any value for image build.

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
[Performance Clinic - Agents](https://www.youtube.com/watch?v=B_oWkBjH-Uk&list=PLqt2rd0eew1bmDn54E2_M2uvbhm_WxY_6&index=37)
[Performance Clinic - Collector](https://www.youtube.com/watch?v=UyRCJ-Xi3a4&list=PLqt2rd0eew1bmDn54E2_M2uvbhm_WxY_6&index=74)

See the following integrations for more information:

- [Dockerized AppMon Agent: Examples](https://github.com/Dynatrace/Dynatrace-AppMon-Docker/tree/master/Dynatrace-Agent-Examples)
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
