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
# A user: biokepi with a consistent UID: 20042
RUN sudo bash -c 'adduser --uid 20042 --disabled-password --gecos '\'''\'' biokepi && passwd -l biokepi && chown -R biokepi:biokepi /home/biokepi'
# Installing GCloud command-line tool with kubectl
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python build-essential'
ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH /home/opam/google-cloud-sdk/bin/:${PATH}
RUN gcloud components install kubectl
# Installing GCloudNFS: cioc/gcloudnfs
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python-pip python-dev build-essential'
RUN sudo bash -c 'pip install --upgrade google-api-python-client'
RUN sudo bash -c 'wget https://raw.githubusercontent.com/cioc/gcloudnfs/master/gcloudnfs -O/usr/bin/gcloudnfs'
RUN sudo bash -c 'chmod a+rx /usr/bin/gcloudnfs'
# Getting more things usefull for Secotrec-GKE deployments
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install zlib1g-dev screen nfs-common graphviz'
RUN opam install --yes tlstunnel
RUN opam pin --yes add coclobas https://github.com/hammerlab/coclobas.git#master
