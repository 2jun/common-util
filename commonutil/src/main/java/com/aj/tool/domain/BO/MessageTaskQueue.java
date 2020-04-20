package com.aj.tool.domain.BO;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

/**
 * @ClassName: MessageTaskQueue
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  11:05
 */
public class MessageTaskQueue {
    public final BlockingQueue<MessageData> queue;

    public MessageTaskQueue(int size) {
        queue = new ArrayBlockingQueue<>(size);
    }

    public void put(MessageData data) {
        try {
            queue.offer(data);
        } catch (Exception e) {
            Thread.currentThread().interrupt();
        }
    }

    public MessageData get() {
        try {
            return queue.take();
        } catch (Exception e) {
            Thread.currentThread().interrupt();
        }
        return null;
    }
}
