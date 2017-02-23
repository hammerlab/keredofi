FROM ocaml/opam:ubuntu-16.04_ocaml-4.03.0
MAINTAINER Sebastien Mondet <seb@mondet.org>
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install cmake r-base tcsh libx11-dev libfreetype6-dev pkg-config wget gawk graphviz xvfb git
# Install wkhtmltopdf from source, this version comes with patched QT necessary for PDF gen
RUN cd /tmp ; wget http://download.gna.org/wkhtmltopdf/0.12/0.12.3/wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN cd /tmp && tar xvfJ wkhtmltox-0.12.3_linux-generic-amd64.tar.xz
RUN cd /tmp/wkhtmltox/bin && sudo chown root:root wkhtmltopdf
RUN sudo cp /tmp/wkhtmltox/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf
# The hard-one: Installing Oracle's Java 7
RUN sudo add-apt-repository --yes ppa:webupd8team/java
RUN sudo apt-get update
# On top of that we have to fight with interactive licensing questions
# Cf. http://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
RUN sudo bash -c 'echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
RUN sudo bash -c 'echo debconf shared/accepted-oracle-license-v1-1 seen true |  debconf-set-selections'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get install --yes --allow-unauthenticated oracle-java7-installer'
