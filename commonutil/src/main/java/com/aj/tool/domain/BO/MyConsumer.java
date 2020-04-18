package com.aj.tool.domain.BO;

import java.util.concurrent.LinkedBlockingQueue;

/**
 * @ClassName: MyConsumer
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  0:45
 */
public class MyConsumer implements Runnable{
    private volatile LinkedBlockingQueue queue;
    private static boolean stopFlag=false;

    public MyConsumer(LinkedBlockingQueue queue) {
        this.queue = queue;
    }


    @Override
    public void run() {
        System.out.println("consumer:"+Thread.currentThread().getName()+" running");
        int count = 0;
        while(!stopFlag){
            try {
                Object take = queue.poll();
                if(take != null){
                    count =0;
                    System.out.println("consumer:"+take);
                    Thread.sleep(1000);
                }else{
                    count++;
                    Thread.sleep(500);
                    System.out.println("consumer waiting");
                }
                if(count >= 20){
                    System.out.println(Thread.currentThread().getName()+"consumer stop");
                    stopFlag=true;
                }
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

        }
    }
}
