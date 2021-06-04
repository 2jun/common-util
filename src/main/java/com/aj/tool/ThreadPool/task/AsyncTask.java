package com.aj.tool.ThreadPool.task;

/**
 * @Date: 2021/6/3 0003 18:30
 * @Version 1.0
 */
public abstract class AsyncTask {
    private int taskOrder;

    public AsyncTask() {
    }

    public AsyncTask(int taskOrder) {
        this.taskOrder = taskOrder;
    }

    public abstract Object run();

    public void callback(Object returnValue) {
    }

    public int getTaskNum() {
        return this.taskOrder;
    }
}
