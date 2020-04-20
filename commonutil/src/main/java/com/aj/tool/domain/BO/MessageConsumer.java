package com.aj.tool.domain.BO;

/**
 * @ClassName: MessageConsumer
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  11:09
 */
public class MessageConsumer  implements Runnable{
    private MessageTaskQueue queue;
    MessageConsumer(MessageTaskQueue queue){
        this.queue=queue;
    }
    @Override
    public void run() {
        for (;;){
            MessageData data = queue.get();
            //拿到数据就对数据进行处理
            System.out.println("消费消息···"+data.toString());
        }
    }
}