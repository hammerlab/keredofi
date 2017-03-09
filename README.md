Keredofi
========

Ketrew-Related `DockerFile`s (contents of this repo are software-generated, cf. 
[`hammerlab/secotrec`](https://github.com/hammerlab/secotrec)).

Available Tags
--------------

See also the Docker-hub [tags](https://hub.docker.com/r/hammerlab/keredofi/tags/).

* `hammerlab/keredofi:ketrew-server-300`:
    * OCaml/Opam environment with [Ketrew](https://github.com/hammerlab/ketrew) 3.0.0 installed.
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/ketrew-server-300/Dockerfile).
* `hammerlab/keredofi:ketrew-server`:
    * OCaml/Opam environment with the `master` version of [Ketrew](https://github.com/hammerlab/ketrew) installed.
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/ketrew-server/Dockerfile).
* `hammerlab/keredofi:biokepi-run`:
    * Ubuntu image with the “system” dependencies that [Biokepi](https://github.com/hammerlab/biokepi) workflows require, and a special `biokepi` user with a fixed UID (useful for shared file-systems).
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/biokepi-run/Dockerfile).
* `hammerlab/keredofi:coclobas-gke-dev`:
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/coclobas-gke-dev/Dockerfile).
* `hammerlab/keredofi:coclobas-gke-biokepi-dev`:
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/coclobas-gke-biokepi-dev/Dockerfile).
* `hammerlab/keredofi:secotrec-default`:
    * OCaml/Opam environment with the `master` version of [Secotrec](https://github.com/hammerlab/secotrec) (and some tools it may use) installed.
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/secotrec-default/Dockerfile).
* `hammerlab/keredofi:ubuntu-docker`:
    * Just an Ubuntu image with `docker.io` installed (useful for testing these images, cf. Secotrec [docs](https://github.com/hammerlab/secotrec#secotrec-make-dockerfiles)).
    * See [`Dockerfile`](https://github.com/hammerlab/keredofi/blob/ubuntu-docker/Dockerfile).
