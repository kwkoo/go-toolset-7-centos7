#!/bin/bash

NAME=golang
STI_SCRIPTS_PATH=/usr/libexec/s2i
VERSION=1.15.6
SUMMARY="Platform for building and running Go $VERSION based applications"
DESCRIPTION="Go $VERSION available as docker container is a base platform for \
building and running various Go $VERSION applications and frameworks. \
Go is an easy to learn, powerful, statically typed language in the C/C++ \
tradition with garbage collection, concurrent programming support, and memory \
safety features."

set -x -e

ctr=$(buildah from "centos/s2i-base-centos7")

buildah config \
  --env NAME="$NAME" \
  --env STI_SCRIPTS_PATH="$STI_SCRIPTS_PATH" \
  --env VERSION="$VERSION" \
  --label summary="$SUMMARY" \
  --label description="$DESCRIPTION" \
  --label io.k8s.description="$DESCRIPTION" \
  --label io.k8s.display-name="Go $VERSION" \
  --label io.openshift.tags="builder,golang,golang1156,rh-golang1156,go" \
  --label com.redhat.component="go-toolset-7" \
  --label name="centos/go-toolset-7-centos7" \
  --label version="1" \
  --label maintainer="Koo Kin Wai <kin.wai.koo@gmail.com>" \
  --label usage="docker run centos/go-toolset-7-centos7" \
  --label org.opencontainers.image.source="https://github.com/kwkoo/go-toolset-7-centos7" \
  $ctr

buildah run $ctr -- yum install -y centos-release-scl-rh yum-utils
buildah run $ctr -- yum-config-manager --enable centos-sclo-rh-testing
buildah run $ctr -- yum clean all -y
buildah run $ctr -- curl -L -o /tmp/go.tar.gz https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz
buildah run $ctr -- \
  /bin/sh -c 'cd /usr/local \
  && \
  tar -zxf /tmp/go.tar.gz'
buildah run $ctr -- rm -f /tmp/go.tar.gz
buildah run $ctr -- ln -s /usr/local/go/bin/go /usr/bin/go

buildah copy $ctr ./s2i/bin/ $STI_SCRIPTS_PATH

buildah run $ctr -- chown -R 1001:0 $STI_SCRIPTS_PATH
buildah run $ctr -- /bin/sh -c 'chown -R 1001:0 $APP_ROOT'

buildah config \
  --user 1001 \
  --cmd $STI_SCRIPTS_PATH/usage \
  $ctr

buildah commit $ctr kwkoo/go-toolset-7-centos7:${VERSION}

buildah tag kwkoo/go-toolset-7-centos7:${VERSION} ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION}
buildah tag kwkoo/go-toolset-7-centos7:${VERSION} ghcr.io/kwkoo/go-toolset-7-centos7:latest
buildah push ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION}
ghcr.io/kwkoo/go-toolset-7-centos7:latest