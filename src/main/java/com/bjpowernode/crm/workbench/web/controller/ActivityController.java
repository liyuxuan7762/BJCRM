package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class ActivityController {

    @Autowired
    private UserService userService;

    // 显示Activity的主页面，完成动态数据的加载
    @RequestMapping("/workbench/activity/index.do")
    public String index(HttpServletRequest request) {
        // 1. 处理请求数据 无
        // 2.调用业务层相关方法
        List<User> userList = userService.queryAllUsers();
        // 3.将数据传递给jsp页面
        request.setAttribute("userList", userList);
        // 4.页面跳转
        return "workbench/activity/index";
    }
}
