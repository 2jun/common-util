package com.aj.tool.config;

import cn.hutool.core.thread.NamedThreadFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @ClassName: BeanConfiguration
 *
 * @Description: TODO
 * @date: 2020-04-17  0:39
 */
@Configuration
public class BeanConfiguration {
    private static Logger logger = LoggerFactory.getLogger(BeanConfiguration.class);
//    电脑的cpu数量
    static int processorsCoreNum = Runtime.getRuntime().availableProcessors();

    @Bean(name = "taskJobExecutor")
    public ExecutorService taskJobExecutor() {
        final int corePoolSize = processorsCoreNum;
        final int maximumPoolSize = processorsCoreNum;
        /**
         *  int corePoolSize, // 1                      		int	核心线程池大小
         *   int maximumPoolSize,  // 2                     	int	最大线程池大小
         *   long keepAliveTime,  // 3                      	long	线程最大空闲时间
         *   TimeUnit unit,  // 4                       		TimeUnit	时间单位
         *   BlockingQueue<Runnable> workQueue, // 5            BlockingQueue<Runnable>	线程等待队列
         *   ThreadFactory threadFactory,  // 6                 ThreadFactory	线程创建工厂
         *   RejectedExecutionHandler handler                   RejectedExecutionHandler	拒绝策略
         */
        ExecutorService executorService = new ThreadPoolExecutor(corePoolSize, maximumPoolSize, 0L,
                TimeUnit.MILLISECONDS, new LinkedBlockingQueue<>(),
                new NamedThreadFactory("zaj-thread-", true));
        logger.info("======》 init executorService zaj-thread ok ! 《=====");
        return executorService;
    }









}
