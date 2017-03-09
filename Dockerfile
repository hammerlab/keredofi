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
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install libsqlite3-dev libpq-dev libev-dev libgmp-dev'
RUN opam install -y tls conf-libev
RUN opam install ketrew.3.0.0
