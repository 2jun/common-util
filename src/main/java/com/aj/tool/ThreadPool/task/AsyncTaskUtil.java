package com.aj.tool.ThreadPool.task;

import cn.hutool.core.collection.CollUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @Date: 2021/6/3 0003 18:27
 * @Version 1.0
 */
public class AsyncTaskUtil {
    private static Logger LOGGER = LoggerFactory.getLogger(AsyncTaskUtil.class);
    private static final int DEFAULT_SIZE = 1000;
    private static ThreadPoolExecutor executor;
    private static boolean setClose;

    public AsyncTaskUtil() {
    }

    public static void setThreadPoolSize(int maxPoolSize) {
        if (!setClose) {
            int coreSize = executor.getCorePoolSize() > maxPoolSize ? maxPoolSize : executor.getCorePoolSize();
            executor.setCorePoolSize(coreSize);
            executor.setMaximumPoolSize(maxPoolSize);
            setClose = true;
        }
    }

    public static void runTask(AsyncTask asyncTask) throws RuntimeException {
        if (asyncTask == null) {
            throw new RuntimeException("async task is null");
        } else {
            CompletableFuture.runAsync(() -> {
                Object returnValue = asyncTask.run();
                asyncTask.callback(returnValue);
            }, executor).exceptionally((e) -> {
                throw new RuntimeException("async task execute failed", e);
            });
        }
    }

    public static Object[] runAll(List<AsyncTask> asyncTaskList) throws RuntimeException {
        if (asyncTaskList != null && !asyncTaskList.isEmpty()) {
            try {
                int size = asyncTaskList.size();
                Object[] returnValueList = new Object[size];
                CompletableFuture<Void>[] array = new CompletableFuture[size];
                int i = 0;

                for (int n = asyncTaskList.size(); i < n; ++i) {
                    AsyncTask asyncTask = asyncTaskList.get(i);
                    CompletableFuture<Void> function = CompletableFuture.runAsync(() -> {
                        Object returnValue = asyncTask.run();
                        int index = asyncTask.getTaskNum();
                        returnValueList[index] = returnValue;
                    }, executor);
                    array[i] = function;
                }

                CompletableFuture.allOf(array).get();
                return returnValueList;
            } catch (Exception var8) {
                LOGGER.error("AsyncTaskUtil runall{}", var8);
                throw new RuntimeException("async task execute failed");
            }
        } else {
            throw new RuntimeException("async task list is null");
        }
    }

    public static void asyncRunAll(List<AsyncTask> asyncTaskList, TaskCallback callback) throws RuntimeException {
        if (asyncTaskList != null && !asyncTaskList.isEmpty()) {
            try {
                CompletableFuture<Void>[] array = new CompletableFuture[asyncTaskList.size()];
                int i = 0;

                for (int n = asyncTaskList.size(); i < n; ++i) {
                    AsyncTask asyncTask = asyncTaskList.get(i);
                    CompletableFuture<Void> function = CompletableFuture.runAsync(() -> {
                        asyncTask.run();
                    }, executor);
                    array[i] = function;
                }

                CompletableFuture<Void> cf = CompletableFuture.allOf(array);
                cf.thenRun(() -> {
                    if (callback != null) {
                        callback.callback();
                    }
                });
                cf.exceptionally((e) -> {
                    LOGGER.error("thread pool task exception e = {}", e);
                    callback.callback();
                    callback.callbackException(e);
                    return null;
                });
            } catch (Exception var7) {
                LOGGER.error("AsyncTaskUtil runall{}", var7);
                throw new RuntimeException("async task execute failed");
            }
        } else {
            throw new RuntimeException("async task list is null");
        }
    }

    public static void threadState() {
    }

    public static ThreadPoolExecutor getThreadPoolExecutor() {
        return executor;
    }

    static {
        executor = new ThreadPoolExecutor(30, 100, 30L, TimeUnit.SECONDS, new ArrayBlockingQueue(1000), new ThreadPoolExecutor.CallerRunsPolicy());
        setClose = false;
    }

    //demo
    public static void main(String[] args) {
        //
//        returnDemo();
        voidDemo();
    }

    //没有返回值
    private static void voidDemo() {
        List<String> lst = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            lst.add(i + "");
        }
        List<AsyncTask> taskList = new ArrayList<>();
        for (String t : lst) {
            AsyncTask asyncTask = new AsyncTask() {
                @Override
                public Object run() {
                    //逻辑
                    return null;
                }
            };
            taskList.add(asyncTask);
        }

        if (CollUtil.isNotEmpty(taskList)) {
            AsyncTaskUtil.runAll(taskList);
        }
    }

    //有返回值
    private static void returnDemo() {
        List<String> lst = new ArrayList<>();
        for (int i = 0; i < 10; i++) {
            lst.add(i + "");
        }
        List<AsyncTask> taskList = new ArrayList<>();
        int task = 0;
        for (String t : lst) {
            AsyncTask asyncTask = new AsyncTask(task) {
                @Override
                public Object run() {
                    //逻辑
                    return t;
                }
            };
            taskList.add(asyncTask);
            task++;
        }

        if (CollUtil.isNotEmpty(taskList)) {
            Object[] objects = AsyncTaskUtil.runAll(taskList);
            Arrays.stream(objects).filter(Objects::nonNull).forEach(callBack -> {
                String tResult = (String) callBack;
                System.out.println(tResult);
            });
        }
    }
}
