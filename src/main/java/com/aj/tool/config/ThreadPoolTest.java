package com.aj.tool.config;

import cn.hutool.core.thread.NamedThreadFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import static java.lang.Thread.sleep;

/**
 * @ClassName: ThreadPoolTest
 *
 * @Description: TODO
 * @date: 2020-04-17  0:44
 */
public class ThreadPoolTest {
    private static Logger logger = LoggerFactory.getLogger(ThreadPoolTest.class);
    static ExecutorService executorService;

    static {
        int processorsCoreNum = Runtime.getRuntime().availableProcessors();
        final int corePoolSize = processorsCoreNum;
        final int maximumPoolSize = processorsCoreNum;
        executorService = new ThreadPoolExecutor(corePoolSize, maximumPoolSize, 0L,
                TimeUnit.MILLISECONDS, new LinkedBlockingQueue<>(),
                new NamedThreadFactory("zaj-thread-", true));
        logger.info("======》 init executorService zaj-thread ok ! 《=====");

    }

    public static void main(String[] args) {
        for (int i = 0; i < 100; i++) {
            int temp = i;
            executorService.submit(() -> {
                System.out.println(temp + "--------------->");
                try {
                    sleep(2000L);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            });
        }
    }
}
