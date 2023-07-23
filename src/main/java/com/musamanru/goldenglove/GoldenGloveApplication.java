package com.musamanru.goldenglove;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@ComponentScan(basePackages = "com.musamanru.goldenglove.home")
@ComponentScan(basePackages = "com.musamanru.goldenglove.user")
@ComponentScan(basePackages = "com.musamanru.goldenglove.team")
@ComponentScan(basePackages = "com.musamanru.goldenglove.teammatch")
@ComponentScan(basePackages = "com.musamanru.goldenglove.notice")
@ComponentScan(basePackages = "com.musamanru.goldenglove.ranking")
@ComponentScan(basePackages = "com.musamanru.goldenglove.chatbot")
@ComponentScan(basePackages = "com.musamanru.goldenglove.sns")
@ComponentScan(basePackages = "com.musamanru.goldenglove.teammatchinfo")
@ComponentScan(basePackages = "com.musamanru.goldenglove.alarm")
@ComponentScan(basePackages = "com.musamanru.goldenglove.soldier")
@ComponentScan(basePackages = "com.musamanru.goldenglove.penalty")
@MapperScan(basePackages = "com/musamanru/goldenglove/user")
@MapperScan(basePackages = "com/musamanru/goldenglove/team")
@MapperScan(basePackages = "com/musamanru/goldenglove/teammatch")
@MapperScan(basePackages = "com/musamanru/goldenglove/notice")
@MapperScan(basePackages = "com/musamanru/goldenglove/ranking")
@MapperScan(basePackages = "com/musamanru/goldenglove/sns")
@MapperScan(basePackages = "com/musamanru/goldenglove/teammatchinfo")
@MapperScan(basePackages = "com/musamanru/goldenglove/alarm")
@MapperScan(basePackages = "com/musamanru/goldenglove/soldier")
@MapperScan(basePackages = "com/musamanru/goldenglove/penalty")

@SpringBootApplication
public class GoldenGloveApplication extends SpringBootServletInitializer {
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(GoldenGloveApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(GoldenGloveApplication.class, args);
    }

}
