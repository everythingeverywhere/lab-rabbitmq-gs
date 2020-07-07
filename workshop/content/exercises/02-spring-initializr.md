For all Spring applications, you should start with the Spring Initializr. The Initializr offers a fast way to pull in all the dependencies you need for an application and does a lot of the set up for you. This example needs only the Spring for RabbitMQ dependency. 

The following command shows the Initializr set up for this sample project:

```execute
curl https://start.spring.io/starter.zip \
        -d dependencies=amqp \
        -d bootVersion=2.3.1.RELEASE \
        -d artifactId=messaging-rabbitmq \
        -d groupId=com.example \
        -d packageName=com.example.messaging-rabbitmq
        -d type=maven-project -o messaging-rabbitmq.zip 
```


