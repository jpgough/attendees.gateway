package com.jpgough.attendees.gateway;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.gateway.route.RouteLocator;
import org.springframework.cloud.gateway.route.builder.RouteLocatorBuilder;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class Application {

	@Bean
	public RouteLocator customRouteLocator(RouteLocatorBuilder builder) {
		return builder.routes()
				.route("attendees", r -> r.path("/attendees/**")
						.filters(f -> f.rewritePath("/attendees/(?<segment>.*)", "/${segment}"))
						.uri("http://attendees:8080"))
				.build();
	}

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

}
