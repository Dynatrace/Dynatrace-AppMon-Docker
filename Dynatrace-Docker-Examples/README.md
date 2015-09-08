# Dynatrace-Docker

This is a documentation of examples and best practices on monitoring Dockerized applications with the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) solution.

## Option I: Inheritance

Typically, the process of Dockerizing an application (more specifically an application component) is split into 2 parts: a *base image* and a *Dockerfile*. The Dockerfile extends, or *derives*, the base image and adds additional functionality on top, resulting in another Docker image.

A comprehensive set of base images is provided on the [Docker Hub](https://hub.docker.com/). I recommend reading [Using Dockerfiles to Automate Building of Images](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images) and [Best Practices for Writing Dockerfiles](https://docs.docker.com/articles/dockerfile_best-practices/) if you want to wrap your head around this this topic.

**TODO**: add overview where a Docker image on the Docker Hub is derived by a Dockerfile

### Examples

This project consists of a growing number of examples, that is, sample integrations of the [Dynatrace Agent](https://community.dynatrace.com/community/display/DOCDT62/Architecture) into a particular technology, such as [Apache HTTPD](http://httpd.apache.org/), [Apache Tomcat](http://tomcat.apache.org/), [NGINX](http://nginx.org/) and [Oracle Glassfish](https://glassfish.java.net/).

Each module contains at least:

- a `Dockerfile` to integrate the Dynatrace Agent into a particular technology
- a `build.sh` which builds an image from the Dockerfile via `docker build`
- a `run.sh` which runs a container from an image via `docker run`

Both `build.sh` and `run.sh` provide sensible default configurations via `ENV` directives or via process argument lists (passed to `docker run`) for basic yet effective build-time and run-time configurations, respectively.

With the inheritance-based approach, you would simply take any of the examples we provide to you as a recipe which you can conveniently modify to suit your needs. Finally, `docker build`, `tag` and `push` the resulting image into a Docker repository, such as the [Docker Hub](https://docs.docker.com/docker-hub/repos/) or the [Docker Registry 2.0](https://docs.docker.com/registry/), from where it then serves as your new base image that contains a particular technology together with the Dynatrace Agent ready to instrument your application you just have to add on top.

**TODO**: add overview (based on previous) where a binary artifact is copied into a Dockerfile that extends from a technology with the Dynatrace agent inside

### Best Practice: Building and Testing Docker Images

The examples in this project follow the same process when it comes to building a particular Docker image: instead of scripting the environment inside a *Dockerfile*, we follow a more integrated approach using [Ansible](http://www.ansible.com) inside our Dockerfiles, which basically looks as follows:

1) Install Ansible  
2) Fetch roles (instruction sets) from [Ansible Galaxy](https://galaxy.ansible.com/)  
3) Create an [Ansible Playbook](http://docs.ansible.com/ansible/playbooks_intro.html) that puts the roles in order and parameterizes them  
4) Execute the playbook and the roles therein (run the installation)  
5) Clean up everything!

Apart from keeping it nice and [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), there is another key aspect to it: *Ansible roles can be automatically tested, while Dockerfiles cannot.* In [Testing Ansible Roles with Test Kitchen, Serverspec and RSpec](http://www.slideshare.net/MartinEtmajer/testing-ansible-roles-with-test-kitchen-serverspec-and-rspec-48185017) I explain how a test-driven approach to infrastructure- and deployment automation can be achieved.

## Option II: Composition

Another, much less intrusive way to integrate the Dynatrace Agent into your existing Docker infrastructure can be achieved basically as follows:

1) Install the Dynatrace (WebServer) Agent on your Docker hosts. Our [Chef](https://github.com/dynatrace/Dynatrace-Chef), [Puppet](https://github.com/dynatrace/Dynatrace-Puppet) and [Ansible](https://github.com/dynatrace/Dynatrace-Ansible) offerings may come in handy here. Using any of these will leave you with the Dynatrace Agents available under `/opt/dynatrace`.  

2) Set `/opt/dynatrace` on your host as a mount point inside your containers via `docker run`'s `-v` or `--volume=` option. The following example will leave you with the agent mounted at `/opt/dynatrace` inside the container run from the image `user/foo`:

**Example**:

```
docker run \
  --volume /opt/dynatrace:/opt/dynatrace \
  user/foo
```

3) Pair the agent with your particular technology. Leverage Docker's ability to override container defaults for running software specified via [`CMD`](https://docs.docker.com/reference/builder/#cmd) in the technology's Dockerfile via `docker run`:

### Java Applications

The Dynatrace Java Agent loads into a process by providing a valid `-agentpath` option to the JVM. This can either be done directly via `java -agentpath ...` or via an environment variable, such as `JAVA_OPTS`, given that it is picked up by the particular technology during startup. Please see our [Java Agent Configuration](https://community.dynatrace.com/community/display/DOCDT62/Java+Agent+Configuration) documentation for more information.

### Apache Tomcat

```
docker run \
  --volume /opt/dynatrace:/opt/dynatrace \
  --env CATALINA_OPTS=-agentpath:/opt/dynatrace/agent/lib64/libdtagent.so=name=tomcat-agent,collector=dtcollector \
  tomcat
```

### Apache HTTPD

```
docker run \
  --volume /opt/dynatrace:/opt/dynatrace \
  httpd \
  sh -c "/opt/dynatrace/init.d/dynaTraceWebServerAgent start; \
         echo LoadModule dtagent_module /opt/dynatrace/agent/lib64/libdtagent.so >> conf/httpd.conf; \
         httpd-foreground"
```

This example requires you to configure the `Name` and `Server` directives in your host's `/opt/dynatrace/agent/conf/dtwsagent.ini` for the *agent name* and *collector host*, respectively.

### NGINX

```
docker run \
  --volume /opt/dynatrace:/opt/dynatrace \
  --env LD_PRELOAD=/opt/dynatrace/agent/lib64/libdtagent.so \
  nginx \
  sh -c "apt-get update && apt-get install -y nginx-dbg gdb elfutils bc; \
         /opt/dynatrace/init.d/dynaTraceWebServerAgent start; \
         nginx -g 'daemon off;'"
```

This example requires you to configure the `Name` and `Server` directives in your host's `/opt/dynatrace/agent/conf/dtwsagent.ini` for the *agent name* and *collector host*, respectively. 

## Conclusion

Both options are used by customers of ours and both have their respective pros and cons. The biggest advantage of enforcing *composition over inheritance* though is that the *agent name* (which determines how the Dynatrace Agent groups into your monitoring profiles) and the *collector host* can be determined at run-time.

[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker-Examples&dt=Dynatrace-Docker-Examples&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()