FROM centos/s2i-base-centos7

ENV NAME=golang \
    STI_SCRIPTS_PATH=/usr/libexec/s2i \
    VERSION=1.16.4

ENV SUMMARY="Platform for building and running Go $VERSION based applications" \
    DESCRIPTION="Go $VERSION available as docker container is a base platform for \
building and running various Go $VERSION applications and frameworks. \
Go is an easy to learn, powerful, statically typed language in the C/C++ \
tradition with garbage collection, concurrent programming support, and memory safety features."

LABEL summary="$SUMMARY" \
      description="$DESCRIPTION" \
      io.k8s.description="$DESCRIPTION" \
      io.k8s.display-name="Go $VERSION" \
      io.openshift.tags="builder,golang,golang1164,rh-golang1164,go" \
      com.redhat.component="go-toolset-7" \
      name="centos/go-toolset-7-centos7" \
      version="1" \
      maintainer="Koo Kin Wai <kin.wai.koo@gmail.com>" \
      org.opencontainers.image.source="https://github.com/kwkoo/go-toolset-7-centos7" \
      usage="docker run centos/go-toolset-7-centos7"

RUN yum install -y centos-release-scl-rh && \
    yum-config-manager --enable centos-sclo-rh-testing && \
    yum clean all -y && \
    cd /tmp && \
    curl -L -o go.tar.gz https://golang.org/dl/go${VERSION}.linux-amd64.tar.gz && \
    cd /usr/local && \
    tar -zxf /tmp/go.tar.gz && \
    rm -f /tmp/go.tar.gz && \
    ln -s /usr/local/go/bin/go /usr/bin/go

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH.
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN chown -R 1001:0 $STI_SCRIPTS_PATH && chown -R 1001:0 $APP_ROOT

USER 1001

# Set the default CMD to print the usage of the language image.
CMD $STI_SCRIPTS_PATH/usage
