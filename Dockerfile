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
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install libpq-dev libev-dev libgmp-dev'
RUN opam install -y tls conf-libev postgresql
# A few opam-pins:
RUN opam pin --yes -n add 'ketrew' 'https://github.com/hammerlab/ketrew.git#master'
RUN opam upgrade --yes
RUN opam install --yes ketrew
# A user: biokepi with a consistent UID: 20042
RUN sudo bash -c 'echo '\''biokepi ALL=(ALL:ALL) NOPASSWD:ALL'\'' > /etc/sudoers.d/biokepi && chmod 440 /etc/sudoers.d/biokepi && chown root:root /etc/sudoers.d/biokepi'
RUN sudo bash -c 'adduser --uid 20042 --disabled-password --gecos '\'''\'' biokepi && passwd -l biokepi && chown -R biokepi:biokepi /home/biokepi'
# Installing aws-cli command-line tool
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python python-pip build-essential'
RUN sudo pip install --upgrade awscli
# Getting more things usefull for Secotrec-GKE deployments
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install zlib1g-dev screen nfs-common graphviz'
RUN opam install --yes tlstunnel
# A few opam-pins:
RUN opam pin --yes -n add 'coclobas' 'https://github.com/hammerlab/coclobas.git#master'
RUN opam upgrade --yes
RUN opam install --yes coclobas
