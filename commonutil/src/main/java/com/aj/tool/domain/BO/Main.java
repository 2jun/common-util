package com.aj.tool.domain.BO;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @ClassName: Main
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  0:46
 */
public class Main {
    public static void main(String[] args) throws InterruptedException {
        ThreadPoolExecutor executor = new ThreadPoolExecutor(4, 8, 2, TimeUnit.SECONDS, new LinkedBlockingQueue<>(1000));
        LinkedBlockingQueue queue = new LinkedBlockingQueue(3);
        MyConsumer myConsumer = new MyConsumer(queue);
        MyProvider myProvider = new MyProvider(queue);
        MyConsumer myConsumer2 = new MyConsumer(queue);
        MyProvider myProvider2 = new MyProvider(queue);
        executor.execute(myProvider);
        executor.execute(myProvider2);
        executor.execute(myConsumer);
        executor.execute(myConsumer2);

        Thread.sleep(3000);
        myProvider.toStop();
        myProvider2.toStop();
        while(true){
            Thread.sleep(1000);
            int activeCount = executor.getActiveCount();
            System.out.println("alive thread count:"+activeCount);
            if(activeCount == 0){
                System.out.println("executor shutdown");
                executor.shutdown();
                break;
            }
        }
    }
}