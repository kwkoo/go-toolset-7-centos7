FROM docker.io/centos/go-toolset-7-centos7:latest@sha256:f515aea549980c0d2595fc9b7a9cc2e5822be952889a200f2bb9954619ceafe3

USER root

LABEL description="Go 1.13 available as docker container is a base platform for building and running various Go 1.13 applications and frameworks. Go is an easy to learn, powerful, statically typed language in the C/C++ tradition with garbage collection, concurrent programming support, and memory safety features." \
      io.k8s.description="Go 1.13 available as docker container is a base platform for building and running various Go 1.13 applications and frameworks. Go is an easy to learn, powerful, statically typed language in the C/C++ tradition with garbage collection, concurrent programming support, and memory safety features." \
      io.k8s.display-name="Go 1.13" \
      maintainer="Koo Kin Wai <glug71@gmail.com>" \
      name="kwkoo/go-toolset-7-centos7" \
      summary="Platform for building and running Go 1.13 based applications" \
      usage="docker run kwkoo/go-toolset-7-centos7"

RUN set -x \
  && \
  yum remove -y \
    go-toolset-7-1.10.2-4.el7.x86_64 \
    go-toolset-7-golang-src-1.10.2-4.el7.noarch \
    go-toolset-7-golang-1.10.2-4.el7.x86_64 \
    go-toolset-7-runtime-1.10.2-4.el7.x86_64 \
    go-toolset-7-golang-bin-1.10.2-4.el7.x86_64 \
  && \
  cd /tmp \
  && \
  wget --quiet https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz \
  && \
  cd /usr/local \
  && \
  tar -zxf /tmp/go1.13.6.linux-amd64.tar.gz \
  && \
  rm -f /tmp/go1.13.6.linux-amd64.tar.gz \
  && \
  ln -s /usr/local/go/bin/go /usr/bin/go

USER 1001
