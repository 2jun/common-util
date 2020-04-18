package com.aj.tool.core.utils;

import com.aj.tool.common.InterceptorChain;
import com.baomidou.mybatisplus.core.toolkit.LambdaUtils;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.support.Property;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;
import org.springframework.util.ReflectionUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public abstract class BeanUtils2 extends BeanUtils {

    private final static InterceptorChain<Object> SUM_CHAIN = new InterceptorChain<>();

    private final static InterceptorChain<Object> MINUS_CHAIN = new InterceptorChain<>();

    private final static InterceptorChain<Object> SORT_TOP = new InterceptorChain<>();

    static {
        SUM_CHAIN.addInterceptor((obj,arg)->{
            if (obj==null){
                return arg[0];
            }
            if (arg[0]==null){
                return obj;
            }
            if (obj instanceof Double){
                return (double)obj+(double)arg[0];
            }
            if (obj instanceof Integer){
                return (int)obj+(int)arg[0];
            }
            if (obj instanceof Long){
                return (long)obj+(long)arg[0];
            }
            throw new FatalBeanException("not support");
        });
        MINUS_CHAIN.addInterceptor((obj,arg)->{
            if (obj==null){
                return arg[0];
            }
            if (arg[0]==null){
                return obj;
            }
            if (obj instanceof Double){
                return (double)arg[0]-(double)obj;
            }
            if (obj instanceof Integer){
                return (int)arg[0]-(int)obj;
            }
            if (obj instanceof Long){
                return (long)arg[0]-(long)obj;
            }
            throw new FatalBeanException("not support");
        });
        SORT_TOP.addInterceptor((before,now)->{
            if (before==null){
                return now[0];
            }
            if (now[0]==null){
                return before;
            }
            if (before instanceof Double){
                return (double)now[0]<(double)before ? before : now[0];
            }
            if (before instanceof Integer){
                return (int)now[0]<(int)before ? before : now[0];
            }
            if (before instanceof Long){
                return (long)now[0]<(long)before ? before : now[0];
            }
            throw new FatalBeanException("not support");
        });
    }

    public static void sumProperties(Object source, Object target,String... ignore) throws BeansException {

        doOperation(source, target,SUM_CHAIN, Type.IGNORE, (String[])ignore);

    }

    @SafeVarargs
    public static <T> void sumPropertiesLambda(Object source, T target, Property<T,Object>... ignore) throws BeansException {
        String[] val = Arrays.stream(ignore).map(
                (x) -> StringUtils.resolveFieldName(LambdaUtils.resolve(x).getImplMethodName())).toArray(String[]::new);
        doOperation(source, target,SUM_CHAIN, Type.IGNORE, val);
    }

    /**
     *  target.Number.properties - source.Number.properties
     */
    public static void minusProperties(Object source, Object target,String... ignore) throws BeansException {
        doOperation(source, target,MINUS_CHAIN, Type.IGNORE, (String[])ignore);
    }

    /**
     *  target.Number.properties - source.Number.properties
     */
    @SafeVarargs
    public static <T> void minusPropertiesLambda(Object source, T target, Property<T,Object>... ignore) throws BeansException {
        String[] val = Arrays.stream(ignore).map(
                    (x) -> StringUtils.resolveFieldName(LambdaUtils.resolve(x).getImplMethodName())).toArray(String[]::new);
        doOperation(source, target,MINUS_CHAIN, Type.IGNORE, val);
    }

    @SafeVarargs
    public static <T> void sortBeforePropertiesLambda(Object source, T target, Property<T,Object>... ignore) throws BeansException {
        String[] val = Arrays.stream(ignore).map(
                (x) -> StringUtils.resolveFieldName(LambdaUtils.resolve(x).getImplMethodName())).toArray(String[]::new);
        doOperation(source, target,SORT_TOP, Type.CONTAINER, val);
    }

    private enum Type{IGNORE,CONTAINER}


    private static void doOperation(Object source,
                                    Object target,
                                    InterceptorChain propertyOperation,
                                    Type type,
                                    String... properties) {
        if(source==null || target==null)return;
        Class<?> actualEditable = target.getClass();
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        Set<String> ignoresSet = new HashSet<>(Arrays.asList(properties));
        for (PropertyDescriptor targetPd : targetPds) {
            if(ignoresSet.size()>0){
                if ( Objects.equals(type, Type.IGNORE) &&
                        ignoresSet.contains(targetPd.getName())){
                    continue;
                }
                if ( Objects.equals(type, Type.CONTAINER) &&
                        !ignoresSet.contains(targetPd.getName())){
                    continue;
                }
            }
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    Method readMethod = sourcePd.getReadMethod();
                    if (readMethod == null)continue;
                    Class<?> firstParameterType = writeMethod.getParameterTypes()[0];
                    Class<?> returnType = readMethod.getReturnType();
                    if (!(Number.class.isAssignableFrom(firstParameterType)&&Number.class.isAssignableFrom(returnType)))
                        continue;
                    if (ClassUtils.isAssignable(firstParameterType, returnType)) {
                        try {
                            ReflectionUtils.makeAccessible(readMethod);
                            Object value = readMethod.invoke(source);
                            ReflectionUtils.makeAccessible(writeMethod);
                            Method readMe = targetPd.getReadMethod();
                            ReflectionUtils.makeAccessible(readMe);
                            Assert.notNull(readMe,"non null");
                            writeMethod.invoke(target,
                                    propertyOperation.interceptor(value,readMe.invoke(target)));
                        }
                        catch (Throwable ex) {
                            throw new FatalBeanException(
                                    "Could not copy property '" + targetPd.getName() + "' from source to target", ex);
                        }
                    }
                }
            }
        }
    }
}
