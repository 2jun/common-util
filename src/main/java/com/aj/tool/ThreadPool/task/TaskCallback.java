package com.aj.tool.ThreadPool.task;

/**
 *
 * @Date: 2021/6/3 0003 18:29
 * @Version 1.0
 */
public interface TaskCallback {
    Object callback();

    default void callbackException(Throwable e) {
    }
}
