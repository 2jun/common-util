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


    public static void main(String[] args) throws Exception {
        stringFormatStudy();
    }

    private static void stringFormatStudy() {
        String str;
        str=String.format("Hi,%s", "小超");
        System.out.println(str);
        str=String.format("Hi,%s %s %s", "小超","是个","大帅哥");
        System.out.println(str);
        System.out.printf("字母c的大写是：%c %n", 'C');
        System.out.printf("布尔结果是：%b %n", "小超".equals("帅哥"));
        System.out.printf("100的一半是：%d %n", 100/2);
        System.out.printf("100的16进制数是：%x %n", 100);
        System.out.printf("100的8进制数是：%o %n", 100);
        System.out.printf("50元的书打8.5折扣是：%f 元%n", 50*0.85);
        System.out.printf("上面价格的16进制数是：%a %n", 50*0.85);
        System.out.printf("上面价格的指数表示：%e %n", 50*0.85);
        System.out.printf("上面价格的指数和浮点数结果的长度较短的是：%g %n", 50*0.85);
        System.out.printf("上面的折扣是%d%% %n", 85);
        System.out.printf("字母A的散列码是：%h %n", 'A');
    }


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

    static int get() {
        return 1;
    }

    static void exec() {
    }
}

@FunctionalInterface
interface Foo {
    int get();
}

@FunctionalInterface
interface UserMapper {
    void insert(User user);
}

@FunctionalInterface
interface OrderMapper {
    int insert(Order order);
}

@FunctionalInterface
interface ThreeConsumer<A,B,C> {
    void accept(A a, B b, C c);
}
