package com.aj.tool.domain.BO;

/**
 * @ClassName: MessageProducer
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  11:06
 */
public class MessageProducer implements Runnable {
    private MessageTaskQueue queue;
    private MessageData data;

    MessageProducer(MessageTaskQueue queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        for (; ; ) {
            data = new MessageData("LYY-" + System.currentTimeMillis() % 9 + "[" + Thread.currentThread().getName() + "]", 1);
            System.out.println("生产消息···" + data.toString());
            queue.put(data);
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}
