package com.aj.tool.designPattern.Chain;

/**
 * @ClassName: Leader
 *
 * @Description: TODO
 * @date: 2020-04-09  1:04
 */
//校级主任处理请假请求
public class Leader extends Handler {

    @Override
    public String handlerRequest(String user, int days) {
        if (days >= 30) {
            System.out.println("校级主任同意" + user + "同学的请假请求");
        } else if (getNextHandler() != null) {
            return getNextHandler().handlerRequest(user, days);
        }
        return null;
    }

}
