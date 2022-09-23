package com.example.golden_glove;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan
@ComponentScan(basePackages = "main")
@ComponentScan(basePackages = "notice")

@MapperScan(basePackages = "notice")
public class GoldenGloveApplication {

	public static void main(String[] args) {
		SpringApplication.run(GoldenGloveApplication.class, args);
	}

}
