FROM ocaml/opam:ubuntu-16.04_ocaml-4.03.0
MAINTAINER Sebastien Mondet <seb@mondet.org>
RUN sudo bash -c 'apt-get update -y'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y upgrade'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install libpq-dev libev-dev libgmp-dev'
# 
# We put back the mothership reprository
RUN opam remote add mothership https://opam.ocaml.org
RUN opam remote remove default
RUN opam update
RUN opam upgrade --yes
RUN opam install -y tls conf-libev
RUN opam pin --yes add ketrew https://github.com/hammerlab/ketrew.git#master
