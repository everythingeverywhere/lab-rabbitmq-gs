FROM quay.io/eduk8s/base-environment:master

COPY --chown=1001:0 . /home/eduk8s/

RUN mv /home/eduk8s/workshop /opt/workshop

RUN fix-permissions /home/eduk8s

USER root

RUN HOME=/root && \

  curl -LJO https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-generic-unix-3.8.5.tar.xz && \

  curl -LJO https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.8.5/rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  sudo tar -xvf rabbitmq-server-generic-unix-3.8.5.tar.xz && \

  sudo tar -xvf rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  gpg --verify rabbitmq-server-generic-unix-3.8.5.tar.xz.asc rabbitmq-server-generic-unix-3.8.5.tar.xz && \
  
  mkdir /home/eduk8s/bin && \
  mv rabbitmq-server-generic-unix-3.8.5.tar.xz.asc rabbitmq-server-generic-unix-3.8.5.tar.xz /home/eduk8s/bin && \

  chmod +x /home/eduk8s/bin/rabbitmq-server-generic-unix-3.8.5.tar.xz.asc && \

  chmod +x /home/eduk8s/bin/rabbitmq-server-generic-unix-3.8.5.tar.xz && \

USER 1001



  