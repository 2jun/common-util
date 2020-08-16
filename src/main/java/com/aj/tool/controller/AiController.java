package com.aj.tool.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * @ClassName: TestController
 * @Author: aiJun
 * @Description: TODO
 * @date: 2020-04-02  2:07
 */
@Controller
@RequestMapping(value = "/")
public class AiController {
    private static Logger logger = LoggerFactory.getLogger(AiController.class);

    @RequestMapping(value = "")
    public Object test1(HttpServletRequest request,String love){
        System.out.println(request);
        return "love5/index";
    }

}
