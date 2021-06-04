package com.aj.tool.ThreadPool.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @Date: 2020-10-26 16:32
 * @Version 1.0
 */
public interface ExceptionTaskCallback extends TaskCallback {
    Logger logger = LoggerFactory.getLogger(ExceptionTaskCallback.class);
    ExceptionDomain exceptionDomain = new ExceptionDomain();


    @Override
    default void callbackException(Throwable e) {
        RuntimeException runtimeException = new RuntimeException(e);
        exceptionDomain.setRuntimeException(runtimeException);
    }

    /**
     * 如果有异常就抛异常
     * @throws RuntimeException
     */
    static void ifExceptionThrows() throws RuntimeException {
        synchronized (ExceptionTaskCallback.class) {
            if (exceptionDomain.getRuntimeException() != null) {
                logger.info("线程等待出现异常 -->{}==>" + exceptionDomain.getRuntimeException().getMessage(), exceptionDomain.getRuntimeException());
                exceptionDomain.setRuntimeException(null);
                throw exceptionDomain.getRuntimeException();
            }
        }

    }

    class ExceptionDomain {
        private RuntimeException runtimeException;

        public RuntimeException getRuntimeException() {
            return runtimeException;
        }

        public void setRuntimeException(RuntimeException runtimeException) {
            this.runtimeException = runtimeException;
        }
    }

}
