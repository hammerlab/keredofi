FROM ocaml/opam:ubuntu-16.04_ocaml-4.03.0
MAINTAINER Sebastien Mondet <seb@mondet.org>
# Update Ubuntu (One upgrade can trigger a minor version change that requires a second `update`)
RUN sudo bash -c 'apt-get update -y'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y upgrade'
RUN sudo bash -c 'apt-get update -y'
# 
# We put back the mothership reprository
RUN opam remote add mothership https://opam.ocaml.org
RUN opam remote remove default
RUN opam update
RUN opam upgrade --yes
# A few opam-pins:
RUN opam pin --yes -n add 'ocamlbuild' '0.9.3'
RUN opam upgrade --yes
RUN opam install --yes ocamlbuild
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install cmake r-base tcsh libx11-dev libbz2-dev libfreetype6-dev pkg-config wget gawk graphviz xvfb git time nfs-common'
# Install wkhtmltopdf from source, this version comes with patched QT necessary for PDF gen
RUN cd /tmp ; wget 'http://downloads.wkhtmltopdf.org/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz'
RUN cd /tmp && tar xvfJ wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN cd /tmp/wkhtmltox/bin && sudo chown root:root wkhtmltopdf
RUN sudo cp /tmp/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
RUN sudo wget https://raw.githubusercontent.com/hammerlab/biokepi/9ee26064498d87a04318ced6613ca50629446465/tools/docker/run/fonts.conf -O /etc/fonts/local.conf
# The hard-one: Installing Oracle's Java 8
RUN sudo add-apt-repository --yes ppa:webupd8team/java
RUN sudo apt-get update
# On top of that we have to fight with interactive licensing questions
# Cf. http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
RUN sudo bash -c 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
RUN sudo bash -c 'echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get install --yes --allow-unauthenticated oracle-java8-installer'
# A user: biokepi with a consistent UID: 20042
RUN sudo bash -c 'echo '\''biokepi ALL=(ALL:ALL) NOPASSWD:ALL'\'' > /etc/sudoers.d/biokepi && chmod 440 /etc/sudoers.d/biokepi && chown root:root /etc/sudoers.d/biokepi'
RUN sudo bash -c 'adduser --uid 20042 --disabled-password --gecos '\'''\'' biokepi && passwd -l biokepi && chown -R biokepi:biokepi /home/biokepi'
USER biokepi
ENV HOME /home/biokepi
WORKDIR /home/biokepi
# Installing aws-cli command-line tool
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python python-pip build-essential'
RUN sudo pip install --upgrade awscli
ENTRYPOINT [ "/usr/bin/time" ]
