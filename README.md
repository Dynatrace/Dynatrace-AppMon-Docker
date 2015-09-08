# Dynatrace-Docker

This is a documentation of examples and best practices on monitoring Dockerized applications with the [Dynatrace Application Monitoring](http://www.dynatrace.com/en/products/application-monitoring.html) solution.

## Option I: Inheritance

Typically, the process of Dockerizing an application (more specifically an application component) is split into 2 parts: a *base image* and a *Dockerfile*. The Dockerfile extends, or *derives*, the base image and adds additional functionality on top, resulting in another Docker image.

A comprehensive set of base images is provided on the [Docker Hub](https://hub.docker.com/). I recommend reading [Using Dockerfiles to Automate Building of Images](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images) and [Best Practices for Writing Dockerfiles](https://docs.docker.com/articles/dockerfile_best-practices/) if you want to wrap your head around this this topic.

**TODO**: insert image where a Docker image is hosted on Docker Hub that is derived by a Dockerfile

### Examples

This project consists of a growing number of examples, that is, sample integrations of the [Dynatrace Agent](https://community.dynatrace.com/community/display/DOCDT62/Architecture) into a particular technology, such as [Apache HTTPD](http://httpd.apache.org/), [NGINX](http://nginx.org/), [Glassfish](https://glassfish.java.net/) and [Tomcat](http://tomcat.apache.org/).

Each module contains at least:

- a `Dockerfile` to integrate the Dynatrace Agent into a particular technology
- a `build.sh` which builds an image from the Dockerfile via `docker build`
- a `run.sh` which runs a container from an image via `docker run`

Both `build.sh` and `run.sh` provide sensible default configurations via `ENV` directives or via process argument lists (passed to `docker run`) for basic yet effective build-time and run-time configurations, respectively.

With the inheritance-based approach, you would simply take any of the examples we provide to you as a recipe which you can conveniently modify to suit your needs. Finally, `docker build`, `tag` and `push` the resulting image into a Docker repository, such as the [Docker Hub](https://docs.docker.com/docker-hub/repos/) or the [Docker Registry 2.0](https://docs.docker.com/registry/), from where it then serves as your new base image that contains a particular technology together with the Dynatrace Agent ready to instrument your application you just have to add on top.

**TODO**: insert image (based on previous image) where a binary artifact is copied into a 3rd part

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

1) Install the Dynatrace Agent on your Docker hosts. Our [Chef](https://github.com/dynatrace/Dynatrace-Chef), [Puppet](https://github.com/dynatrace/Dynatrace-Puppet) and [Ansible](https://github.com/dynatrace/Dynatrace-Ansible) offerings may come in handy here. Using any of these will leave you with the Dynatrace Agent available under `/opt/dynatrace`.  

2) Set `/opt/dynatrace` on your host as a mount point inside your containers via `docker run`'s `-v` or `--volume=` option. The following example will leave you with the agent mounted at `/dynatrace` inside the container run from the image `user/foo`:

**Example**:

```
docker run --volume=/opt/dynatrace:/dynatrace user/foo
```

3) Integrate the agent into your particular technology by leveraging Docker's ability to override the `CMD` specified in the original Dockerfile via `docker run`:

**Example: Generic Java**

JAVA_OPTS=

**Example: Apache HTTPD**

LoadModule via command line?

**Example: NGINX**

LD_PRELOAD_PATH=...

[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker-Examples&dt=Dynatrace-Docker-Examples&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()