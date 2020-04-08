package com.aj.tool.designPattern.Chain;

/**
 * @ClassName: Handler
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-09  0:57
 */
//定义一个抽象的处理者类
public abstract class Handler {
    public Handler sucesser;

    //定义一个抽象的处理请求的方法
    public abstract String handlerRequest(String user,int days);

    //获取当前角色的下一个处理者角色
    public Handler getNextHandler() {
        return sucesser;
    }
    //设置当前角色的下一个处理者角色
    public void setNextHandler(Handler sucesser) {
        this.sucesser=sucesser;
    }

}