package com.aj.tool;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan(basePackages = "com.aj.tool.filter")
public class CommonutilApplication {

	public static void main(String[] args) {
		SpringApplication.run(CommonutilApplication.class, args);
	}

}
