#!/bin/bash

VERSION=1.15.2

docker tag kwkoo/go-toolset-7-centos7:${VERSION} ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION}
docker tag kwkoo/go-toolset-7-centos7:${VERSION} ghcr.io/kwkoo/go-toolset-7-centos7:latest
docker push ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION}
docker push ghcr.io/kwkoo/go-toolset-7-centos7:latest
