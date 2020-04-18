package com.aj.tool.designPattern.Chain;

/**
 * @ClassName: Department
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-09  1:03
 */
//院系主任处理请假请求
public class Department extends Handler {

    @Override
    public String handlerRequest(String user, int days) {

        if (days < 30) {
            System.out.println("院系主任同意" + user + "同学的请假请求");
        } else {
            System.out.println("院系主任无法处理" + user + "同学的请假请求");
        }
        if (getNextHandler() != null) {
            return getNextHandler().handlerRequest(user, days);
        }
        return null;
    }

}