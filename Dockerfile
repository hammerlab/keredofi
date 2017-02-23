FROM ocaml/opam:ubuntu-16.04_ocaml-4.03.0
MAINTAINER Sebastien Mondet <seb@mondet.org>
RUN sudo bash -c 'apt-get update -y'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y upgrade'
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install libpq-dev libev-dev libgmp-dev'
RUN opam install -y tls conf-libev
RUN opam pin --yes add ketrew https://github.com/hammerlab/ketrew.git#master
ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH /home/opam/google-cloud-sdk/bin/:${PATH}
RUN gcloud components install kubectl
RUN opam pin --yes add coclobas https://github.com/hammerlab/coclobas.git#master
