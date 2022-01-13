package com.aj.tool.util;

import java.io.File;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Scanner;

public class FileUtil {
    private static String QUIT = "q!";
    private static int deleteNum;


    public static void main(String[] args) {
        //创建一个目录对象 文件路径随意更换
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("请输入需要做删除的文件夹!退出请输入" + QUIT);
            String inputString = scanner.next();
            if (QUIT.equals(inputString)) {
                System.out.println("程序已退出!");
                return;
            }
            System.out.println("请输入需要做删除的文件后缀，退出请输入" + QUIT);
            String endWith = scanner.next();
            if (QUIT.equals(inputString)) {
                System.out.println("程序已退出!");
                return;
            }
            File file = new File(inputString);
//            .vep.baiduyun.downloading
            deleteFileEndWith(file, endWith);
            System.out.println("删除文件总数=" + deleteNum);
        }
    }

    public static void deleteFileEndWith(File file, String endWith) {
        if (file == null || !file.exists()) {
            System.out.println("您输入的不是文件夹，程序退出");
            return;
        }
        //获得文件对象的子文件对象列表
        File[] files = file.listFiles();
        if(files==null || files.length<=0){
            return;
        }
        //遍历这些子文件
        Iterator<File> iterator = Arrays.stream(files).iterator();
        while (iterator.hasNext()) {
            File next = iterator.next();
            System.out.print("\t");
            //打印文件
            String name = next.getName();
            System.out.println(name);
            //下载中的文件要删除
            if (name.endsWith(endWith)) {
                next.delete();
                deleteNum++;
            }
            //判断这些子文件是否是目录
            if (next.isDirectory()) {
                //递归的方式来遍历
                deleteFileEndWith(next, endWith);
            }
        }
    }
}
