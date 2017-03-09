# Ubuntu, updated, and with Docker installed
FROM ubuntu
MAINTAINER Sebastien Mondet <seb@mondet.org>
# Update Ubuntu (One upgrade can trigger a minor version change that requires a second `update`)
RUN bash -c 'apt-get update -y'
RUN bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y upgrade'
RUN bash -c 'apt-get update -y'
RUN bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install docker.io'
