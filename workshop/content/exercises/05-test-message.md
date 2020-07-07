#### Send a Test Message

In this sample, test messages are sent by a `CommandLineRunner`, which also waits for the latch in the receiver and closes the application context. The following listing (from `src/main/java/com.example.messagingrabbitmq/Runner.java`) shows how it works:

```
cat > Runner.java <<- "EOF"
package com.example.messagingrabbitmq;

import java.util.concurrent.TimeUnit;

import org.springframework.amqp.rabbit.core.RabbitTemplate;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class Runner implements CommandLineRunner {

  private final RabbitTemplate rabbitTemplate;
  private final Receiver receiver;

  public Runner(Receiver receiver, RabbitTemplate rabbitTemplate) {
    this.receiver = receiver;
    this.rabbitTemplate = rabbitTemplate;
  }

  @Override
  public void run(String... args) throws Exception {
    System.out.println("Sending message...");
    rabbitTemplate.convertAndSend(MessagingRabbitmqApplication.topicExchangeName, "foo.bar.baz", "Hello from RabbitMQ!");
    receiver.getLatch().await(10000, TimeUnit.MILLISECONDS);
  }

}
EOF
```
Move the file to the proper location:
```
mv Runner.java /messaging-rabbitmq/src/main/java/com.example.messagingrabbitmq
```

Notice that the template routes the message to the exchange with a routing key of foo.bar.baz, which matches the binding.

In tests, you can mock out the runner so that the receiver can be tested in isolation