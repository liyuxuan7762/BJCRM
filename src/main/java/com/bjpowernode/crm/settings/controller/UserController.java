package com.bjpowernode.crm.settings.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
    // 创建Controller的规范是看这个Controller里面返回的资源位置是不是在同一个目录
    // 一个资源目录对应一个Controller
    // 这个例子中index.jsp和要访问的login页面不在一个目录中，因此要创建controller

    // /WEB-INF/pages/settings/qx/user/toLogin.do 为啥可以省略？
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

}
