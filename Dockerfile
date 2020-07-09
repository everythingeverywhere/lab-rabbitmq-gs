FROM quay.io/eduk8s/base-environment:master

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

USER root

RUN HOME=/root && \

  curl -LJO https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-generic-unix-3.8.5.tar.xz && \

  curl -LJO https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  curl -LJO https://packages.erlang-solutions.com/erlang/rpm/centos/6/x86_64/esl-erlang_R16B03-6~centos~6_amd64.rpm && \

  su -c 'rpm -Uvh https://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm' && \

  rpm -Uvh esl-erlang_R16B03-6~centos~6_amd64.rpm && \

  sudo tar -xvf rabbitmq-server-generic-unix-3.8.5.tar.xz && \

  sudo tar -xvf rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  gpg --verify rabbitmq-server-generic-unix-3.8.5.tar.xz.asc rabbitmq-server-generic-unix-3.8.5.tar.xz && \
  
  sudo mkdir /home/eduk8s/bin && \

  sudo mv rabbitmq-server-generic-unix-3.8.5.tar.xz.asc rabbitmq-server-generic-unix-3.8.5.tar.xz /home/eduk8s/bin && \

  chmod +x /home/eduk8s/bin/rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  chmod +x /home/eduk8s/bin/rabbitmq-server-generic-unix-3.8.5.tar.xz && \

USER 1001



  