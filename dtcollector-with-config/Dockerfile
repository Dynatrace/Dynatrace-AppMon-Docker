FROM centic9/dtcollector-base:6.1-latest

MAINTAINER Dominik Stadler "dominik.stadler@dynatrace.com"

# Set to low amount of memory initially, Collectors need more memory if many Agents are connections, change this to whatever you would like the Collector to use
RUN sed -i -e 's/-Xmx[0-9]\+[MGmg]/-Xmx768M/g' /dynatrace/dtcollector.ini
RUN sed -i -e 's/-Xms[0-9]\+[MGmg]/-Xms200M/g' /dynatrace/dtcollector.ini

COPY collector.config.xml /dynatrace/collector/conf/
