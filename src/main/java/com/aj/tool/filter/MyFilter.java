package com.aj.tool.filter;

import lombok.extern.slf4j.Slf4j;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

/**
 * @Author: aiJun
 * @Date: 2020-08-15 15:11
 * @Version 1.0
 */
@Slf4j
@WebFilter(filterName = "myFilter", urlPatterns = "/*")
public class MyFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        log.info(filterConfig.getFilterName() + " init");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
        try {
            log.info("访问者的ip={}", com.pes.jd.util.SecurityMUtil.getIpAddr((HttpServletRequest) request));
            chain.doFilter(request, response);
        } catch (Exception e) {
            log.error("error!", e);
        }
    }

    @Override
    public void destroy() {
    }
}