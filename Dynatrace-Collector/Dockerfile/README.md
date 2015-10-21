# Dynatrace-Collector

The following directory contains a `Dockerfile` and accompanying scripts for building and running the [Dynatrace Collector](https://community.dynatrace.com/community/display/DOCDT62/Architecture).

A ready-built image is available on the [Docker Hub](https://hub.docker.com/r/dynatrace/collector/).

### Building and Testing Docker Images

Instead of scripting the environment inside a *Dockerfile*, we follow a more integrated approach using [Ansible](http://www.ansible.com) inside our Dockerfiles, which basically looks as follows:

1) Install Ansible  
2) Fetch roles (instruction sets) from [Ansible Galaxy](https://galaxy.ansible.com/)  
3) Create an [Ansible Playbook](http://docs.ansible.com/ansible/playbooks_intro.html) that puts the roles in order and parameterizes them  
4) Execute the playbook and the roles therein (run the installation)  
5) Clean up everything!

Apart from keeping it nice and [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), there is another key aspect to it: *Ansible roles can be automatically tested, while Dockerfiles cannot.* In [Testing Ansible Roles with Test Kitchen, Serverspec and RSpec](http://www.slideshare.net/MartinEtmajer/testing-ansible-roles-with-test-kitchen-serverspec-and-rspec-48185017) I explain how a test-driven approach to infrastructure- and deployment automation can be achieved.

[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker%2FDynatrace-Collector%2FDDockerfile&dt=Dynatrace-Docker%2FDynatrace-Collector%2FDDockerfile&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()