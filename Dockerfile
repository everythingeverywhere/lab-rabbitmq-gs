FROM quay.io/eduk8s/base-environment:master

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

USER root

RUN HOME=/root && \
    curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz --output apache-maven-3.6.3-bin.tar.gz && \

    tar xzvf apache-maven-3.6.3-bin.tar.gz && \

    chmod +x apache-maven-3.6.3 && \

    sudo mv ./apache-maven-3.6.3-bin.tar.gz ../../bin \

USER 1001

RUN fix-permissions /home/eduk8s