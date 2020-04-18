package com.aj.tool.core.utils;

import org.springframework.util.Assert;
import org.springframework.util.CollectionUtils;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;

import java.util.*;
import java.util.function.*;
import java.util.stream.Collectors;

/**
 *
 */
public abstract class MapUtils {

    private static MultiValueMap NON = new LinkedMultiValueMap();

    public static <K,V> MultiValueMap<K,V> extractForMap(List<V> values, Function<V,K> mapKey, Predicate<V> test){
        if (CollectionUtils.isEmpty(values)||Objects.isNull(mapKey)){
            return NON;
        }
        MultiValueMap<K,V> res = new LinkedMultiValueMap<>();
        for (V value : values) {
            if (test==null||test.test(value)) {
                res.add(
                        mapKey.apply(value), value
                );
            }
        }
        return res;
    }

    /**
     *  extract the {@code values} To MultiValueMap
     */
    public static <K,V> MultiValueMap<K,V> extract(List<V> values, Function<V,K> mapKey){
        return extractForMap(values,mapKey,null);
    }

    public static <K,V,Z> Map<Z,Map<K,V>> extract(Map<K,V> values, Function<K,Z> mapKey){
        if (CollectionUtils.isEmpty(values)||Objects.isNull(mapKey)){
            return NON;
        }
        Map<Z,Map<K,V>> res = new LinkedHashMap<>();
        for (Map.Entry<K, V> kvEntry : values.entrySet()) {

            final Z key = mapKey.apply(kvEntry.getKey());
            Map<K, V> kvMap = res.computeIfAbsent(key, k -> new LinkedHashMap<>());
            kvMap.put(kvEntry.getKey(),kvEntry.getValue());
        }
        return res;
    }

    public static <K,VK,VV> Map<K,Map<VK,VV>> extract(
            List<VV> args, Function<VV,K> oneLevelKey, Function<VV,VK> twoLevelKey, Predicate<VV> test, BiFunction<VV,VV,VV> mergeVal){
        if(CollectionUtils.isEmpty(args)){
            return Collections.emptyMap();
        }
        Map<K,Map<VK,VV>> res = new HashMap<>();
        for (VV arg : args) {
            if (test!=null){
                if (!test.test(arg)){
                    continue;
                }
            }
            // 一级key
            final K key = oneLevelKey.apply(arg);
            Map<VK, VV> vkvvMap = res.get(key);
            if (vkvvMap == null){
                vkvvMap = new HashMap<>();
            }
            // 二级key
            final VK vkey = twoLevelKey.apply(arg);
            final VV vv = vkvvMap.get(vkey);
            if (vv == null){
                vkvvMap.put(vkey,arg);
            }else {
                vkvvMap.put(vkey,mergeVal.apply(vv,arg));
            }
            res.put(key,vkvvMap);
        }
        return res;
    }

    public static <K,V> void sortMultiple(
            LinkedHashMap<K,V> map,
            BiConsumer<Map.Entry<K,V>,Map.Entry<K,V>> operation){
        Map.Entry<K,V> en = null;
        for (Map.Entry<K, V> kvEntry : map.entrySet()) {
            if(en!=null) {
                operation.accept(en,kvEntry);
            }
            en = kvEntry;
        }
    }

    public static <K,VK,VV> Map<K,Map<VK,List<VV>>> extracts(List<VV> args,Function<VV,K> oneLevelKey, Function<VV,VK> twoLevelKey){

        if(CollectionUtils.isEmpty(args)){
            return Collections.emptyMap();
        }
        Map<K,Map<VK,List<VV>>> res = new HashMap<>();
        for (VV arg : args) {
            final K key = oneLevelKey.apply(arg);
            Map<VK, List<VV>> vkvvMap = res.get(key);
            if (vkvvMap == null){
                vkvvMap = new HashMap<>();
            }
            final VK vkey = twoLevelKey.apply(arg);
            List<VV> vv = vkvvMap.get(vkey);
            if (vv == null){
                vv = new ArrayList<>();
                vkvvMap.put(vkey,vv);
            }
            vv.add(arg);
            res.put(key,vkvvMap);
        }
        return res;

    }

    public static <CENTER,K,V> MultiValueMap<K,V> extract(
            List<K> keys,
            Function<K,CENTER> functionKeys,
            List<V> values,
            Function<V,CENTER> functionValues){
        return extract(keys,functionKeys,values,functionValues,null);
    }

    public static <CENTER,K,V> MultiValueMap<K,V> extract(
            List<K> keys,
            Function<K,CENTER> functionKeys,
            List<V> values,
            Function<V,CENTER> functionValues,
            Consumer<CENTER> keyIfNull){
        if(CollectionUtils.isEmpty(keys)){
            return NON;
        }
        Assert.notNull(keys," keys must be non null ");
        Assert.notNull(values," values must be non null ");
        Assert.notNull(functionKeys," functionKeys must be non null ");
        Assert.notNull(functionValues," functionValues must be non null ");
        MultiValueMap<K,V> res = new LinkedMultiValueMap<>();
        final Map<CENTER, List<V>> collect = values.stream().collect(Collectors.groupingBy(functionValues));
        for (K key : keys) {
            res.put(key,collect.get(functionKeys.apply(key)));
        }
        return res;
    }

}
