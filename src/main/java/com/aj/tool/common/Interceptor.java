package com.aj.tool.common;

public interface Interceptor<T> {
    T interceptor(T t, Object[] arg);
}