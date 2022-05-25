## Spring Cloud Gateway Example

### Pre-reqs

- [kubectl](https://kubernetes.io/docs/tasks/tools/#kubectl)
- [az](https://docs.microsoft.com/en-us/cli/azure/)


### Structure

This project contains the configuration for a basic Spring Cloud Gateway.
It has a single route configured as part of the `Application.java` 

```java
return builder.routes()
    .route("attendees", r -> r.path("/attendees/**")
            .filters(f -> f.rewritePath("/attendees/(?<segment>.*)", "/${segment}"))
            .uri("http://attendees:8080"))
    .build();
```

There is a `docker-compose.yaml` file to bring up the gateway and the attendees service locally.

### Running on k8s

In the platform folder there is a `setup.sh` script.
When deployed this will create a k8s cluster on AKS and deploy the attendees service and a gateway.
You can test this is working by running the following from a browser:

```
http://{EXTERNAL-IP}/attendees
```