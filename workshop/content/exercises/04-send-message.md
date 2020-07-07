#### Register the Listener and Send a Message

Spring AMQP’s `RabbitTemplate` provides everything you need to send and receive messages with RabbitMQ. However, you need to:

- Configure a message listener container.

- Declare the queue, the exchange, and the binding between them.

- Configure a component to send some messages to test the listener.

> Spring Boot automatically creates a connection factory and a RabbitTemplate, reducing the amount of code you have to write.

You will use `RabbitTemplate` to send messages, and you will register a `Receiver` with the message listener container to receive messages. The connection factory drives both, letting them connect to the RabbitMQ server. The following listing (from `src/main/java/com.example.messagingrabbitmq/MessagingRabbitApplication.java`) shows how to create the application class:

```
cat > MessagingRabbitApplication.java <<- "EOF"
package com.example.messagingrabbitmq;

import org.springframework.amqp.core.Binding;
import org.springframework.amqp.core.BindingBuilder;
import org.springframework.amqp.core.Queue;
import org.springframework.amqp.core.TopicExchange;
import org.springframework.amqp.rabbit.connection.ConnectionFactory;
import org.springframework.amqp.rabbit.listener.SimpleMessageListenerContainer;
import org.springframework.amqp.rabbit.listener.adapter.MessageListenerAdapter;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class MessagingRabbitmqApplication {

  static final String topicExchangeName = "spring-boot-exchange";

  static final String queueName = "spring-boot";

  @Bean
  Queue queue() {
    return new Queue(queueName, false);
  }

  @Bean
  TopicExchange exchange() {
    return new TopicExchange(topicExchangeName);
  }

  @Bean
  Binding binding(Queue queue, TopicExchange exchange) {
    return BindingBuilder.bind(queue).to(exchange).with("foo.bar.#");
  }

  @Bean
  SimpleMessageListenerContainer container(ConnectionFactory connectionFactory,
      MessageListenerAdapter listenerAdapter) {
    SimpleMessageListenerContainer container = new SimpleMessageListenerContainer();
    container.setConnectionFactory(connectionFactory);
    container.setQueueNames(queueName);
    container.setMessageListener(listenerAdapter);
    return container;
  }

  @Bean
  MessageListenerAdapter listenerAdapter(Receiver receiver) {
    return new MessageListenerAdapter(receiver, "receiveMessage");
  }

  public static void main(String[] args) throws InterruptedException {
    SpringApplication.run(MessagingRabbitmqApplication.class, args).close();
  }

}
EOF
```

Move the file to the proper location:
```
mv MessagingRabbitApplication.java /messaging-rabbitmq/src/main/java/com.example.messagingrabbitmq
```

`@SpringBootApplication` is a convenience annotation that adds all of the following:

- `@Configuration`: Tags the class as a source of bean definitions for the application context.

- `@EnableAutoConfiguration`: Tells Spring Boot to start adding beans based on classpath settings, other beans, and various property settings. For example, if `spring-webmvc` is on the classpath, this annotation flags the application as a web application and activates key behaviors, such as setting up a `DispatcherServlet`.

- `@ComponentScan`: Tells Spring to look for other components, configurations, and services in the `com/example` package, letting it find the controllers.

The `main()` method uses Spring Boot’s `SpringApplication.run()` method to launch an application. Did you notice that there was not a single line of XML? There is no `web.xml` file, either. This web application is 100% pure Java and you did not have to deal with configuring any plumbing or infrastructure.

The bean defined in the `listenerAdapter()` method is registered as a message listener in the container (defined in `container()`). It listens for messages on the `spring-boot` queue. Because the `Receiver` class is a POJO, it needs to be wrapped in the `MessageListenerAdapter`, where you specify that it invokes `receiveMessage`.

> JMS queues and AMQP queues have different semantics. For example, JMS sends queued messages to only one consumer. While AMQP queues do the same thing, AMQP producers do not send messages directly to queues. Instead, a message is sent to an exchange, which can go to a single queue or fan out to multiple queues, emulating the concept of JMS topics.

The message listener container and receiver beans are all you need to listen for messages. To send a message, you also need a Rabbit template.

The `queue()` method creates an AMQP queue. The `exchange()` method creates a topic exchange. The `binding()` method binds these two together, defining the behavior that occurs when `RabbitTemplate` publishes to an exchange.

> Spring AMQP requires that the `Queue`, the `TopicExchange`, and the `Binding` be declared as top-level Spring beans in order to be set up properly.

In this case, we use a topic exchange, and the queue is bound with a routing key of `foo.bar.#`, which means that any messages sent with a routing key that begins with `foo.bar.` are routed to the queue.