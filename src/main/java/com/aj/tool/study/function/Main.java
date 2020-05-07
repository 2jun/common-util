package com.aj.tool.study.function;

import com.aj.tool.domain.DTO.User;
import com.aj.tool.domain.Order;

import java.util.concurrent.Callable;
import java.util.function.Function;

/**
 * @Author: aiJun
 * @Date: 2020-04-25 20:22
 * @Version 1.0
 */
public class Main {

    public static void test01() throws Exception {
        Runnable r = () -> System.out.println("-------------------->>>>>>>>>>>>>>");
        r.run();

        Callable<String> c2 = () -> "hello";
        System.out.println(c2.call());

//        自定义函数式接口
        UserMapper u2 = (user) -> System.out.println("user insert success!!!");
        u2.insert(new User());
        OrderMapper o2 = (order) -> 1;
        System.out.println(o2.insert(new Order()));

//        使用函数式接口写代码
        Function<Integer, Integer> f1 = a -> {
            int sum = 0;
            for (int i = 1; i < a; i++) {
                sum += i;
            }
            return sum;
        };
        System.out.println(f1.apply(100));
    }

    static int get(){
        return 1;
    }
    static void exec(){
    }

    public static void main(String[] args) throws Exception {
        Runnable r1 = Main::get;
        Runnable r2 = Main::exec;
        r1.run();
        r2.run();

    }

}

@FunctionalInterface
interface Foo{
    int get();
}

@FunctionalInterface
interface UserMapper{
    void insert(User user);
}

@FunctionalInterface
interface OrderMapper{
    int insert(Order order);
}