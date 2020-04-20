package com.aj.tool.ThreadPool;

import java.util.List;
import java.util.concurrent.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @ClassName: CallBackThreadPoolDemo
 * @Author: aiJun
 * @Description: TODO   回调线程池demo 异步阻塞获取返回值
 * @date: 2020-04-21  1:59
 */
public class CallBackThreadPoolDemo {

    public static void main(String[] args) {
        List<Integer> numLst = Stream.iterate(1,(a)->a*10).limit(5).collect(Collectors.toList());
//        List<Integer> numLst = Arrays.asList(1, 2, 3, 4, 5);
        final int taskThreadCount = Math.min(numLst.size(), 80);
        ExecutorService executorService = new ThreadPoolExecutor(taskThreadCount, taskThreadCount, 0L,
                TimeUnit.MILLISECONDS, new LinkedBlockingQueue<>(numLst.size()));
        CompletionService<String> completionService = new ExecutorCompletionService<>(executorService);
        /**
         * 1.按照维度分组
         */
        for (Integer integer : numLst) {
            completionService.submit(() -> integer + " ----> 异步方法");
        }
        /**
         * 2.关闭线程池（等提交的线程完成任务就关闭线程池）
         */
        executorService.shutdown();
        /**
         * 3.获取返回值 与1的循环次数一样。阻塞获取返回值
         */
        for (Integer integer : numLst) {
            String s = null;
            try {
                s = completionService.take().get();
            } catch (Exception e) {
                /**
                 * 如果出现异常立即关闭线程池
                 */
                executorService.shutdownNow();
                e.printStackTrace();
            }
            System.out.println(s);
        }

    }

}
