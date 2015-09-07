# Dynatrace-Docker

A collection of Dockerfiles and accompanying scripts for building and running components of the Dynatrace Application Monitoring solution inside Docker.

## Components

Each component contains at least:

- a `Dockerfile` containing instructions to containerize a Dynatrace component
- a `build.sh` which builds an image from the Dockerfile via `docker build`
- a `run.sh` which runs a container from an image via `docker run`

Please take a look at each for more information.

## License

Licensed under the MIT License. See the LICENSE file for details.
