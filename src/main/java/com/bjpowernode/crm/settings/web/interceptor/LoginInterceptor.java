package com.bjpowernode.crm.settings.web.interceptor;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.settings.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    // 这个拦截器的目的是拦截非登录的用户通过url来直接直接访问项目主页从而导致网站不安全的行为
    // 只有登录的用户才可以访问主页，未登录的用户自动跳转到登陆页面
    @Override
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        // 这个方法在用户发送请求还没有得到相应的时候执行
        // 返回值为true则放行，false则不放行
        // 1. 获取session，判断用户是否已经登录
        HttpSession session = httpServletRequest.getSession();
        User user = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        // 2.判断用户是否为空 如果为空，则跳转到登录页面
        if (user == null) {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath());
            return false;
        }
        // 3.不为空 放行
        return true;
        // 4. 去springmvc.xml中配置拦截器
    }

    @Override
    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        // 这个方法在响应后还未到达客户端的时候执行
    }

    @Override
    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {
        // 这个方法在相应已经到达客户端的时候执行
    }
}
