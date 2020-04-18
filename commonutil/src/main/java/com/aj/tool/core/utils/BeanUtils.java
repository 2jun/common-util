package com.aj.tool.core.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.FatalBeanException;
import org.springframework.util.Assert;
import org.springframework.util.ClassUtils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.*;

public abstract class BeanUtils extends org.springframework.beans.BeanUtils {

    public static final ThreeFunction COUNT_PROCESS = (a, b, c) -> {
        if (a == null || b == null) return c;

        if (!Objects.equals(a.getClass(), b.getClass())) {
            return c;
        }
        if (a instanceof Integer) {
            if ((Integer) a == -1 || (Integer) b == -1) {
                return -1;
            }
        }
        if (a instanceof Double) {
            if ((Double) a == -1 || (Double) b == -1) {
                return (double) -1;
            }
        }
        if (a instanceof Long) {
            if ((Long) a == -1 || (Long) b == -1) {
                return (long) -1;
            }
        }
        return c;
    };

    public static void copyProperties(Object source, Object target) throws BeansException {
        if (source == null || target == null) {
            return;
        }
        copyProperties(source, target, null, true, (String[]) null);
    }

    public static void copyProperties(Object source, Object target, String... properties) throws BeansException {
        if (source == null || target == null) {
            return;
        }
        copyProperties(source, target, null, true, properties);
    }

    public static void copyPropertiesForContainProperties(Object source, Object target, String... properties) throws BeansException {
        if (source == null || target == null) {
            return;
        }
        copyProperties(source, target, null, false, properties);
    }

    private static void copyProperties(Object source, Object target, Class<?> editable, boolean ignore, String... ignoreProperties)
            throws BeansException {

        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");

        Class<?> actualEditable = target.getClass();
        if (editable != null) {
            if (!editable.isInstance(target)) {
                throw new IllegalArgumentException("Target class [" + target.getClass().getName() +
                        "] not assignable to Editable class [" + editable.getName() + "]");
            }
            actualEditable = editable;
        }
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);

        Set<String> ignoreOrNotIgnoreList = (ignoreProperties != null ? new HashSet<>(Arrays.asList(ignoreProperties)) : null);

        for (PropertyDescriptor targetPd : targetPds) {
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null && (
                    (!ignore && ignoreOrNotIgnoreList.contains(targetPd.getName())) ||
                            (ignore && (ignoreOrNotIgnoreList == null || !ignoreOrNotIgnoreList.contains(targetPd.getName())))
            )) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    Method readMethod = sourcePd.getReadMethod();
                    final Class<?> parameterType = writeMethod.getParameterTypes()[0];
                    final Class<?> returnType = readMethod.getReturnType();
                    final boolean number = ClassUtils.isAssignable(Number.class, parameterType) &&
                            ClassUtils.isAssignable(Number.class, returnType);
                    final boolean assignable = ClassUtils.isAssignable(parameterType, returnType);
                    if (readMethod != null && (assignable || number)) {
                        try {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }
                            Object value = readMethod.invoke(source);
                            if (value == null) {
                                continue;
                            }
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                            if (!assignable) {
                                if (number) {
                                    final Number nu = (Number) value;
                                    if (parameterType.equals(Double.class)) {
                                        value = nu.doubleValue();
                                    } else if (parameterType.equals(Integer.class)) {
                                        value = nu.intValue();
                                    } else if (parameterType.equals(Long.class)) {
                                        value = nu.longValue();
                                    } else {
                                        throw new RuntimeException("无法支持的类型---" + nu);
                                    }
                                } else {
                                    throw new RuntimeException("类型不通，无法copy");
                                }
                            }
                            writeMethod.invoke(target, value);
                        } catch (Throwable ex) {
                            throw new FatalBeanException(
                                    "Could not copy property '" + targetPd.getName() + "' from source to target", ex);
                        }
                    }
                }
            }
        }
    }

    public static void countPropertyVal(Object source, Object target, String... ignoreProperties)
            throws BeansException {
        countPropertyVal(source, target, null, ignoreProperties);

    }

    @FunctionalInterface
    public interface ThreeFunction<A, B, C, T> {
        T apply(A a, B b, C c);
    }

    public static void countPropertyVal(Object source, Object target, ThreeFunction<Object, Object, Object, Object> handlerValue, String... ignoreProperties)
            throws BeansException {

        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");

        Class<?> actualEditable = target.getClass();
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        List<String> ignoreList = (ignoreProperties != null ? Arrays.asList(ignoreProperties) : null);

        for (PropertyDescriptor targetPd : targetPds) {
            Method writeMethod = targetPd.getWriteMethod();
            Method targetReadMethod = targetPd.getReadMethod();
            if (writeMethod != null && targetReadMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    Method readMethod = sourcePd.getReadMethod();
                    Class<?> returnType = readMethod.getReturnType();
                    if (!Number.class.isAssignableFrom(returnType)) {
                        continue;
                    }
                    if (readMethod != null &&
                            ClassUtils.isAssignable(writeMethod.getParameterTypes()[0], returnType)) {
                        try {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }
                            Object value = readMethod.invoke(source);
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }
                            Object value1 = targetReadMethod.invoke(target);
                            Object count = count(value, value1);
                            if (handlerValue != null) {
                                count = handlerValue.apply(value, value1, count);
                            }
                            if (count == null) {
                                continue;
                            }
                            writeMethod.invoke(target, count);
                        } catch (Throwable ex) {
                            throw new FatalBeanException(
                                    "Could not add property '" + targetPd.getName() + "' from source to target", ex);
                        }
                    }
                }
            }
        }
    }

    public static void avgPropertyVal(Object source, Object target, int dividend, String... ignoreProperties)
            throws BeansException {

        Assert.notNull(source, "Source must not be null");
        Assert.notNull(target, "Target must not be null");

        Class<?> actualEditable = target.getClass();
        PropertyDescriptor[] targetPds = getPropertyDescriptors(actualEditable);
        List<String> ignoreList = (ignoreProperties != null ? Arrays.asList(ignoreProperties) : null);

        for (PropertyDescriptor targetPd : targetPds) {
            Method writeMethod = targetPd.getWriteMethod();
            if (writeMethod != null && (ignoreList == null || !ignoreList.contains(targetPd.getName()))) {
                PropertyDescriptor sourcePd = getPropertyDescriptor(source.getClass(), targetPd.getName());
                if (sourcePd != null) {
                    Method readMethod = sourcePd.getReadMethod();
                    if (readMethod != null && (
                            Number.class.isAssignableFrom(readMethod.getReturnType())
                    )) {
                        try {
                            if (!Modifier.isPublic(readMethod.getDeclaringClass().getModifiers())) {
                                readMethod.setAccessible(true);
                            }
                            Object value = readMethod.invoke(source);
                            if (value == null) {
                                continue;
                            }
                            if (!Modifier.isPublic(writeMethod.getDeclaringClass().getModifiers())) {
                                writeMethod.setAccessible(true);
                            }

                            Object o = avgVal(value, dividend, writeMethod.getParameterTypes()[0]);
                            writeMethod.invoke(target, o);
                        } catch (Throwable ex) {
                            throw new FatalBeanException(
                                    "Could not copy property '" + targetPd.getName() + "' from source to target", ex);
                        }
                    }
                }
            }
        }

    }

    private static Object avgVal(Object value, int dividend, Class targetCla) {
        if (value instanceof Integer) {
            if (targetCla.equals(Double.class)) {
                return ((Integer) value) * 1.0 / dividend;
            }
            return ((Integer) value) / dividend;
        }
        if (value instanceof Double) {
            return ((Double) value) / dividend;
        }
        if (value instanceof Long) {
            if (targetCla.equals(Double.class)) {
                return ((Long) value) * 1.0 / dividend;
            }
            return ((Long) value) / dividend;
        }
        throw new RuntimeException();
    }

    private static Object count(Object value, Object value1) {
        if (value == null) {
            return value1;
        }
        if (value1 == null) {
            return value;
        }
        Class<?> aClass = value.getClass();
        Class<?> bClass = value1.getClass();
        if (aClass != bClass) {
            throw new RuntimeException(" the two arg type must is same ");
        }
        if (value instanceof Integer) {
            final Integer v1 = (Integer) value;
            final Integer v2 = (Integer) value1;
            if (v1 < 0 || v2 < 0) {
                return null;
            }
            return v1 + v2;
        }
        if (value instanceof Double) {
            final Double v1 = (Double) value;
            final Double v2 = (Double) value1;
            if (v1 < 0 || v2 < 0) {
                return null;
            }
            return v1 + v2;
        }
        if (value instanceof Long) {
            final Long v1 = (Long) value;
            final Long v2 = (Long) value1;
            if (v1 < 0 || v2 < 0) {
                return null;
            }
            return v1 + v2;
        }
        throw new NotSupportException();
    }

    private static class NotSupportException extends RuntimeException {
    }


}
