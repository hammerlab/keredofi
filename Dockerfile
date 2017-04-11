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
RUN opam install -y tls conf-libev
# A few opam-pins:
RUN opam pin --yes -n add 'ketrew' 'https://github.com/hammerlab/ketrew.git#master'
RUN opam upgrade --yes
RUN opam install --yes ketrew
# Installing GCloud command-line tool with kubectl
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python build-essential'
ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
ENV CLOUDSDK_INSTALL_DIR /opt
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH ${CLOUDSDK_INSTALL_DIR}/google-cloud-sdk/bin/:${PATH}
RUN gcloud components install kubectl
RUN sudo bash -c 'echo '\''# GCloud installation:'\'' >> /etc/profile.d/gcloud_installation.sh'
RUN sudo bash -c 'echo '\''export CLOUDSDK_INSTALL_DIR=/opt'\'' >> /etc/profile.d/gcloud_installation.sh'
RUN sudo bash -c 'echo '\''export PATH=${CLOUDSDK_INSTALL_DIR}/google-cloud-sdk/bin/:${PATH}'\'' >> /etc/profile.d/gcloud_installation.sh'
RUN sudo bash -c 'chmod 666 /etc/profile.d/gcloud_installation.sh'
RUN bash -c 'echo Created file /etc/profile.d/gcloud_installation.sh'
RUN bash -c 'cat /etc/profile.d/gcloud_installation.sh '
# A few opam-pins:
RUN opam pin --yes -n add 'coclobas' 'https://github.com/hammerlab/coclobas.git#master'
RUN opam upgrade --yes
RUN opam install --yes coclobas
