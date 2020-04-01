package com.aj.tool.core.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

public final class CollectionUtils {


    /**
     * 将一个list均分成n个list,主要通过偏移量来实现的
     *
     * @param source
     * @return
     */
    public static <T> List<List<T>> avgAssignLst(List<T> source, final int limitLstNum) {

        int sourceSize = source.size();
        int lstNum = limitLstNum;
        if (sourceSize < lstNum) {
            lstNum = sourceSize;
        }
        int number = sourceSize / lstNum; // 商
        int remaider = sourceSize % lstNum; // (余数)

        List<List<T>> result = new ArrayList<List<T>>(lstNum + 1);

        int offset = 0;// 偏移量


        List<T> subLst;
        for (int i = 0; i < lstNum; i++) {
            subLst = null;
            if (remaider > 0) {
                subLst = source.subList(i * number + offset, (i + 1) * number + offset + 1);
                remaider--;
                offset++;
            } else {
                subLst = source.subList(i * number + offset, (i + 1) * number + offset);
            }
            result.add(subLst);
        }
        return result;
    }

    /**
     * 将source均分为 subLstSize 为一个的集合
     *
     * @param source
     * @param subLstSize
     * @param <T>
     * @return
     */
    public static <T> List<List<T>> smallToLst(List<T> source, int subLstSize) {


        if (source == null || source.isEmpty()) {
            return new ArrayList<List<T>>(0);
        }
        List<List<T>> result = new ArrayList<List<T>>(source.size() / subLstSize + 1);
        if (source.size() <= subLstSize) {
            result.add(source);
            return result;
        }

        final int sourceSize = source.size();
        int offset = 0;//偏移量
        while (true) {

            if (offset + subLstSize < sourceSize) {
                result.add(source.subList(offset, offset + subLstSize));
                offset += subLstSize;
            } else {
                result.add(source.subList(offset, sourceSize));
                break;
            }
        }

        return result;
    }


    /**
     * 将集合中的字段进行累加求和
     *
     * @param t
     * @param list
     * @param ignoreField
     * @param <T>
     * @return
     */
    public static <T> T fieldMerge(T t, List<T> list, String... ignoreField) {
        /**
         * 单个对象直接返回
         */
        if (org.apache.commons.collections.CollectionUtils.isEmpty(list)) {
            return t;
        } else if (list.size() == 1) {
            return list.get(0);
        } else {
            list.stream().reduce((u11, u12) -> {
                Class<?> aClass = t.getClass();
                a:
                for (Field f : aClass.getDeclaredFields()) {
                    f.setAccessible(Boolean.TRUE);
                    /**
                     * 忽略的字段不参与计算
                     */
                    for (String s : ignoreField) {
                        if (s.equals(f.getName())) {
                            continue a;
                        }
                    }

                    try {

                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                }
                return t;
            });

        }
        return t;

    }


    public static void main(String[] args) {
        List<Integer> integers = new ArrayList<>();

        integers.add(1);
        integers.add(2);
        integers.add(3);
        integers.add(4);
        integers.add(5);
        integers.add(6);
        integers.add(7);
        integers.add(8);
        integers.add(9);
        integers.add(10);
        integers.add(11);
        integers.add(12);
        integers.add(13);

        List<List<Integer>> lists = avgAssignLst(integers, 5);


        System.out.println(lists);
    }

}
