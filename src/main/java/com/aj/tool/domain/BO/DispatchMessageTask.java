package com.aj.tool.domain.BO;

import java.util.HashMap;

/**
 * @ClassName: DispatchMessageTask
 *
 * @Description: TODO
 * @date: 2020-04-19  11:08
 */
public class DispatchMessageTask  implements Runnable{
    private MessageTaskQueue queue;
    private HashMap<Integer,MessageTaskQueue> hashMap;
    public DispatchMessageTask(MessageTaskQueue queue,HashMap hashMap){
        this.hashMap = hashMap;
        this.queue = queue;
    }
    @Override
    public void run() {
        for (;;){
            try {
                MessageData data = queue.get();
                //这里就是所谓的哈希算法，System.nanoTime()这个函数产生的值
                //就是哈希值，对size取模运算，会得到0，1，2这三个数，他们一一对应一个队列
                int index = (int) (System.nanoTime() % hashMap.size());
                MessageTaskQueue messageTaskQueue = hashMap.get(index);
                System.out.println("消息分发···"+index+" 号队列获得消息: "+data.toString());
                messageTaskQueue.put(data);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
