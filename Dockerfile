FROM quay.io/eduk8s/base-environment:master

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

USER root

RUN HOME=/root && \

    curl https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-3.8.5-1.el8.noarch.rpm.asc --output rabbitmq-server-3.8.5-1.el8.noarch.rpm.asc && \

    curl -LJO https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-3.8.5-1.el8.noarch.rpm && \

    chmod +x rabbitmq-server-3.8.5-1.el8.noarch.rpm.asc && \
    chmod +x rabbitmq-server-3.8.5-1.el8.noarch.rpm && \

    mv rabbitmq-server-3.8.5-1.el8.noarch.rpm.asc rabbitmq-server-3.8.5-1.el8.noarch.rpm /bin && \

    su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm' && \

    sudo yum -y update && \
    
    sudo dnf -y install erlang && \

    rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc && \

    yum install rabbitmq-server-3.8.5-1.el8.noarch.rpm && \

    chkconfig rabbitmq-server on \

USER 1001

RUN fix-permissions /home/eduk8s


  