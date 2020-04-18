package com.aj.tool.designPattern.Chain;

/**
 * @ClassName: HeadTeacher
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-09  1:01
 */
//班主任处理请假请求
public class HeadTeacher extends Handler {
    @Override
    public String handlerRequest(String user, int days) {
        if (days < 5) {
            System.out.println("班主任同意" + user + "同学的请假请求");
        } else {
            System.out.println("班主任无法处理" + user + "同学的请假请求");
        }
        // 如果下一个执行者不为空，由下一个执行者执行
        if (getNextHandler() != null) {
            return getNextHandler().handlerRequest(user, days);
        }
        return null;
    }

}
