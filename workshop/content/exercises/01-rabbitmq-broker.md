#### Set up the RabbitMQ Broker
Before you can build your messaging application, you need to set up a server to handle receiving and sending messages.

[RabbitMQ is an AMQP server](https://www.rabbitmq.com/download.html) 


Launch the server with default settings by running the following command in a terminal window:

```execute
rabbitmq-server
```

You should see output similar to the following:
```
            RabbitMQ 3.1.3. Copyright (C) 2007-2013 VMware, Inc.
##  ##      Licensed under the MPL.  See https://www.rabbitmq.com/
##  ##
##########  Logs: /usr/local/var/log/rabbitmq/rabbit@localhost.log
######  ##        /usr/local/var/log/rabbitmq/rabbit@localhost-sasl.log
##########
            Starting broker... completed with 6 plugins.
```            

You can also use Docker Compose to quickly launch a RabbitMQ server if you have Docker running locally. There is a docker-compose.yml in the root of the complete project in Github. It is very simple, as the following listing shows:

```
rabbitmq:
  image: rabbitmq:management
  ports:
    - "5672:5672"
    - "15672:15672"
```