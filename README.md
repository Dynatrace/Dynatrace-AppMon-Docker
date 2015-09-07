# Dynatrace-Docker

A collection of Dockerfiles and accompanying scripts for building and running components of the [Dynatrace Application Monitoring](http://www.dynatrace.com/en_us/application-performance-management/products/application-monitoring.html) solution inside Docker.

## Dynatrace Components

Each component contains at least:

- a `Dockerfile` containing instructions to containerize a Dynatrace component
- a `build.sh` which builds an image from the Dockerfile via `docker build`
- a `run.sh` which runs a container from an image via `docker run`

Please take a look at each for more information.

## How to Monitor your Dockerized Applications?

The `Dynatrace-Docker-Examples` directory contains a growing number examples and best practices on how to monitor your Dockerized application with Dynatrace.

## License

Licensed under the MIT License. See the LICENSE file for details.
[![analytics](https://www.google-analytics.com/collect?v=1&t=pageview&_s=1&dl=https%3A%2F%2Fgithub.com%2FdynaTrace&dp=%2FDynatrace-Docker&dt=Dynatrace-Docker&_u=Dynatrace~&cid=github.com%2FdynaTrace&tid=UA-54510554-5&aip=1)]()