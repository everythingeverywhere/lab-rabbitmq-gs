FROM quay.io/eduk8s/base-environment:master

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

USER root

RUN HOME=/root && \
    # curl https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz --output apache-maven-3.6.3-bin.tar.gz && \

    # tar xzvf apache-maven-3.6.3-bin.tar.gz && \

    # chmod +x apache-maven-3.6.3 && \

    # sudo mv ./apache-maven-3.6.3-bin.tar.gz /home/eduk8s/bin && \

    su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm' && \
    
    sudo dnf -y install erlang && \

    rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc && \

    yum install rabbitmq-server-3.8.5-1.el8.noarch.rpm && \

    chkconfig rabbitmq-server on \

USER 1001

RUN fix-permissions /home/eduk8s