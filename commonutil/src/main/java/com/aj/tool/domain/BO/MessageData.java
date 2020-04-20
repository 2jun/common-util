package com.aj.tool.domain.BO;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * @ClassName: MessageData
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-19  11:03
 */
@Getter@Setter
@ToString
public class MessageData {
    private String name;
    private int id;
    public MessageData(){

    }
    public MessageData(String name,int age){
        this.id = age;
        this.name = name;
    }
}
