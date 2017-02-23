FROM ocaml/opam:ubuntu-16.04_ocaml-4.03.0
MAINTAINER Sebastien Mondet <seb@mondet.org>
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install libsqlite3-dev libpq-dev libev-dev libgmp-dev
RUN opam install -y tls conf-libev
RUN opam install ketrew.3.0.0
