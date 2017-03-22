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
# Installing GCloud command-line tool with kubectl
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install python build-essential'
ENV CLOUDSDK_CORE_DISABLE_PROMPTS true
RUN bash -c 'curl https://sdk.cloud.google.com | bash'
ENV PATH ${HOME}/google-cloud-sdk/bin/:${PATH}
RUN gcloud components install kubectl
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install dnsutils libpq-dev libev-dev libgmp-dev'
# A few opam-pins:
RUN opam pin --yes -n add 'ketrew' 'https://github.com/hammerlab/ketrew.git#master'
RUN opam pin --yes -n add 'biokepi' 'https://github.com/hammerlab/biokepi.git#master'
RUN opam pin --yes -n add 'secotrec' 'https://github.com/hammerlab/secotrec.git#master'
RUN opam upgrade --yes
RUN opam install --yes ketrew biokepi secotrec tls
RUN sudo bash -c 'DEBIAN_FRONTEND=noninteractive apt-get -y install vim emacs tmux git-hub samtools vcftools'
# A few opam-pins:
RUN opam pin --yes -n add 'epidisco' 'https://github.com/hammerlab/epidisco.git#master'
RUN opam pin --yes -n add 'ogene' 'https://github.com/hammerlab/ogene.git#master'
RUN opam upgrade --yes
RUN opam install --yes epidisco ogene
