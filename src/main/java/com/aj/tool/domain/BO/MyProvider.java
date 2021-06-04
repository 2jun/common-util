package com.aj.tool.domain.BO;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.LinkedBlockingQueue;

/**
 * @ClassName: MyProvider
 *
 * @Description: TODO
 * @date: 2020-04-19  0:41
 */

public class MyProvider implements Runnable {
    private volatile LinkedBlockingQueue queue;
    private static boolean flag = false;

    public MyProvider(LinkedBlockingQueue queue) {
        this.queue = queue;
    }

    public void toStop(){
        System.out.println("stop..");
        this.flag=true;
    }

    @Override
    public void run() {
        while (!flag){
            try {
                queue.put(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))+"mytime");
                queue.put("mytime");
            } catch (InterruptedException e) {
                e.printStackTrace();
            }

            try {
                System.out.println(Thread.currentThread().getName()+" sleep 500ms");
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
