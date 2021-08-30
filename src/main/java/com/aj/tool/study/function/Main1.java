package com.aj.tool.study.function;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

/**
 * @Author: aiJun
 * @Date: 2021/8/29 0029 21:00
 * @Version 1.0
 */
public class Main1 {
    public static void main(String[] args) {
        ActionListener actionListener = (e) -> {
            System.out.println(e.getID());
            System.out.println(e.getActionCommand());
        };
        actionListener.actionPerformed(new ActionEvent("source", 1, "command"));
    }
}
