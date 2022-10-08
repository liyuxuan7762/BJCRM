package com.bjpowernode.crm.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IndexController {
    // 这里实际上完成路径应该是http://localhost:8080/crm
    // 但是SpringMVC会帮我们拼接http://localhost:8080/crm
    // 因此这里只需要写/
    @RequestMapping("/")
    public String index() {
        // 这里这个方法的修饰符必须为public
        // 原因是SpringMVC需要通过DispatcherServlet来去调用index方法
        // 如果我们设置为private，那么DispatcherServlet就无法获取到这个方法
        return "index";
    }
}
