package com.aj.tool.util;

import java.io.File;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Scanner;

public class FileUtil {
    public static final String split = ",";
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
            System.out.println("请输入需要做删除的文件后缀(多种后缀请用" + split + "号分割)，退出请输入" + QUIT);
            String endWith = scanner.next();
            if (QUIT.equals(inputString)) {
                System.out.println("程序已退出!");
                return;
            }
            File file = new File(inputString);
//            .vep.baiduyun.downloading
            deleteFileEndWith(file, endWith);
            System.err.println("删除文件总数=" + deleteNum);
        }
    }

    public static void deleteFileEndWith(File file, String endWiths) {
        if (file == null || !file.exists()) {
            System.out.println("您输入的不是文件夹，程序退出");
            return;
        }
        //获得文件对象的子文件对象列表
        File[] files = file.listFiles();
        if (files == null || files.length <= 0) {
            return;
        }
        //遍历这些子文件
        Iterator<File> iterator = Arrays.stream(files).iterator();

        first:
        while (iterator.hasNext()) {
            File next = iterator.next();
            //打印文件
            String name = next.getName();
//            System.out.println(name);
            //下载中的文件要删除
            String[] splitArray = endWiths.split(split);
            for (String endWith : splitArray) {
                if (name.endsWith(endWith)) {
                    deleteFile(next);
                    deleteNum++;
                    continue first;
                }
            }

            //判断这些子文件是否是目录
            if (next.isDirectory()) {
                //递归的方式来遍历
                deleteFileEndWith(next, endWiths);
            }
        }
    }
//    课后作业

    /**
     * 删除文件，可以是文件或文件夹
     *
     * @param fileName：要删除的文件名
     * @return 删除成功返回true，否则返回false
     */
    public static boolean delete(String fileName) {
        File file = new File(fileName);
        return deleteFile(file);
    }

    /**
     * 删除文件，可以是文件或文件夹
     *
     * @param file：要删除的文件名
     * @return 删除成功返回true，否则返回false
     */
    public static boolean deleteFile(File file) {
        if (!file.exists()) {
            System.out.println("删除文件失败:" + file.getAbsolutePath() + "不存在！");
            return false;
        } else {
            if (file.isFile())
                return deleteFile(file.getAbsolutePath());
            else
                return deleteDirectory(file.getAbsolutePath());
        }
    }


    /**
     * 删除单个文件
     *
     * @param fileName：要删除的文件的文件名
     * @return 单个文件删除成功返回true，否则返回false
     */
    public static boolean deleteFile(String fileName) {
        File file = new File(fileName);
        // 如果文件路径所对应的文件存在，并且是一个文件，则直接删除
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
//                System.out.println("删除单个文件" + fileName + "成功！");
                return true;
            } else {
                System.out.println("删除单个文件" + fileName + "失败！");
                return false;
            }
        } else {
            System.out.println("删除单个文件失败：" + fileName + "不存在！");
            return false;
        }
    }

    /**
     * 删除目录及目录下的文件
     *
     * @param dir：要删除的目录的文件路径
     * @return 目录删除成功返回true，否则返回false
     */
    public static boolean deleteDirectory(String dir) {
        // 如果dir不以文件分隔符结尾，自动添加文件分隔符
        if (!dir.endsWith(File.separator))
            dir = dir + File.separator;
        File dirFile = new File(dir);
        // 如果dir对应的文件不存在，或者不是一个目录，则退出
        if ((!dirFile.exists()) || (!dirFile.isDirectory())) {
            System.out.println("删除目录失败：" + dir + "不存在！");
            return false;
        }
        boolean flag = true;
        // 删除文件夹中的所有文件包括子目录
        File[] files = dirFile.listFiles();
        for (int i = 0; i < files.length; i++) {
            // 删除子文件
            if (files[i].isFile()) {
                flag = deleteFile(files[i].getAbsolutePath());
                if (!flag)
                    break;
            }
            // 删除子目录
            else if (files[i].isDirectory()) {
                flag = deleteDirectory(files[i].getAbsolutePath());
                if (!flag)
                    break;
            }
        }
        if (!flag) {
            System.out.println("删除目录失败！");
            return false;
        }
        // 删除当前目录
        if (dirFile.delete()) {
            System.out.println("删除目录" + dir + "=成功！");
            return true;
        } else {
            return false;
        }
    }

}
