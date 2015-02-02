FROM java:7

MAINTAINER Dominik Stadler "dominik.stadler@dynatrace.com"

# Define version of the Collector in the base image, can be overridden later
ENV DT_VERSION 6.1.0

RUN mkdir dynatrace

# instead of copying over the big jar-file and extracting it there, rather copy only the pieces 
# from the full installation that we need
# dynatrace-collector-6.0.0.6738-unix.jar
#COPY dynatrace-collector-${DT_VERSION}.*-unix.jar .
#RUN echo -e "Y\nY" | java -jar dynatrace-${DT_VERSION}.*-linux-x64.jar
COPY dynatrace-${DT_VERSION}/collector dynatrace/collector
COPY dynatrace-${DT_VERSION}/dtcollector* dynatrace/
COPY dynatrace-${DT_VERSION}/jre dynatrace/jre
COPY dynatrace-${DT_VERSION}/tools dynatrace/tools

VOLUME /dynatrace/log

WORKDIR dynatrace

RUN chmod a+x dtcollector
	
# export the default agent port
EXPOSE 9998

# default instruction for starting the collector, derived images are needed to actually configure it
CMD [ "./dtcollector" ]
