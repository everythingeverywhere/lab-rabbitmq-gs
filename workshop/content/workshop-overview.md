# Messaging with RabbitMQ

This guide walks you through the process of setting up a RabbitMQ AMQP server that publishes and subscribes to messages and creating a Spring Boot application to interact with that RabbitMQ server.

## What You Will Build

You will build an application that publishes a message by using Spring AMQP’s `RabbitTemplate` and subscribes to the message on a POJO by using `MessageListenerAdapter`.

#### How do you complete exercises?
In this guide you will be be able to use a built in code editor which is the las tab at the top of the screen labeled `Editor`

If you have to execute a command you can type it in or simply click on the running man to have it run for you. 

Try it bellow, click on the running man next to the command:

```execute
echo hello world
```

#### Set up

We have already intalled JDK8 and we only need Gradle 4+ or Maven 3.2+ for our builds. We will use Maven in this guide
