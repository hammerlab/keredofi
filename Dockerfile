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
# A user: biokepi with a consistent UID: 20042
RUN sudo bash -c 'echo '\''opam ALL=(ALL:ALL) NOPASSWD:ALL'\'' > /etc/sudoers.d/biokepi && chmod 440 /etc/sudoers.d/biokepi && chown root:root /etc/sudoers.d/biokepi'
RUN sudo bash -c 'adduser --uid 20042 --disabled-password --gecos '\'''\'' biokepi && passwd -l biokepi && chown -R biokepi:biokepi /home/biokepi'
# Installing GCloud command-line tool with kubectl
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python build-essential'
ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH ${HOME}/google-cloud-sdk/bin/:${PATH}
RUN gcloud components install kubectl
# Installing GCloudNFS: cioc/gcloudnfs
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python-pip python-dev build-essential wget'
RUN sudo bash -c 'pip install --upgrade google-api-python-client'
RUN sudo bash -c 'wget https://raw.githubusercontent.com/cioc/gcloudnfs/master/gcloudnfs -O/usr/bin/gcloudnfs'
RUN sudo bash -c 'chmod a+rx /usr/bin/gcloudnfs'
# Getting more things usefull for Secotrec-GKE deployments
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install zlib1g-dev screen nfs-common graphviz'
RUN opam install --yes tlstunnel
# A few opam-pins:
RUN opam pin --yes -n add 'coclobas' 'https://github.com/hammerlab/coclobas.git#master'
RUN opam upgrade --yes
RUN opam install --yes coclobas
