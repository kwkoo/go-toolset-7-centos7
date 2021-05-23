#!/bin/bash

cd `dirname $0`
BASE=`pwd`
cd - >> /dev/null

# Extract version from Dockerfile
VERSION="$(grep VERSION= ${BASE}/Dockerfile | sed 's/.*VERSION=\([^\\ ]*\).*/\1/')"

docker build -t ghcr.io/kwkoo/go-toolset-7-centos7:${VERSION} ${BASE}
