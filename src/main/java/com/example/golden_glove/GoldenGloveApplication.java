package com.example.golden_glove;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan
@ComponentScan(basePackages = "main")
@ComponentScan(basePackages = "user")
@ComponentScan(basePackages = "team")

@MapperScan(basePackages = "user")
@MapperScan(basePackages = "team")
@SpringBootApplication
public class GoldenGloveApplication {

	public static void main(String[] args) {
		SpringApplication.run(GoldenGloveApplication.class, args);
	}

}
