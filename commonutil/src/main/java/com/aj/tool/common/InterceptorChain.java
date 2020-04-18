package com.aj.tool.common;

import java.util.ArrayList;
import java.util.List;

public class InterceptorChain<T> {

    private List<Interceptor<T>> interceptors = new ArrayList<>();

    public void addInterceptor(Interceptor<T> interceptor) {
        interceptors.add(interceptor);
    }

    public T interceptor(T t, Object... arg) {
        for (Interceptor<T> interceptor : interceptors) {
            t = interceptor.interceptor(t, arg);
        }
        return t;
    }

}