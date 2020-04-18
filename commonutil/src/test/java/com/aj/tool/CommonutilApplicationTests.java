package com.aj.tool;

import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.concurrent.ExecutorService;



@RunWith(SpringRunner.class)
@SpringBootTest(classes = CommonutilApplication.class)
class CommonutilApplicationTests {

    private static Logger logger = LoggerFactory.getLogger(CommonutilApplicationTests.class);

    @Autowired
    ExecutorService executorService;

	@Test
	void contextLoads() {
	}
	@Test
	void testThreadPool() {
        executorService.submit(() ->
                logger.info("sss")
        );
	}

}
