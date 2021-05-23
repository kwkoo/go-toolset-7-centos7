#!/bin/bash

cd `dirname $0`
BASE=`pwd`
cd - >> /dev/null

# Extract version from Dockerfile
VERSION="$(grep VERSION= ${BASE}/Dockerfile | sed 's/.*VERSION=\([^\\ ]*\).*/\1/')"

docker tag ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION} ghcr.io/kwkoo/go-toolset-7-centos7:latest
docker push ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION}
docker push ghcr.io/kwkoo/go-toolset-7-centos7:latest
