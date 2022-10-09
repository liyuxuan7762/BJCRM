package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private UserService userService;
    // 创建Controller的规范是看这个Controller里面返回的资源位置是不是在同一个目录
    // 一个资源目录对应一个Controller
    // 这个例子中index.jsp和要访问的login页面不在一个目录中，因此要创建controller

    // /WEB-INF/pages/settings/qx/user/toLogin.do 为啥可以省略？
    @RequestMapping("/settings/qx/user/toLogin.do")
    public String toLogin() {
        return "settings/qx/user/login";
    }

    @RequestMapping("/settings/qx/user/login.do")
    @ResponseBody
    public Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletRequest request) {
        // 登录方法 1.接收前端数据并封装数据为map 2.调用service处理数据 3.返回结果

        // 1.封装数据为map
        Map<String, Object> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        // 2.调用service方法
        User user = userService.queryUserByLoginActAndPwd(map);

        // 3.根据返回结果做判断

        ReturnObj obj = new ReturnObj();

        if (user == null) {
            // 因为用户名密码错误而登录失败
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("用户名或密码错误");
        } else {
            // 判断账号是否过期 将日期都转化为字符串，然后比较字符串
            String nowStr = DateUtils.getFormatDate(new Date());
            if (nowStr.compareTo(user.getExpireTime()) > 0) {
                // 账号过期
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("账号过期");
            } else if (Constants.RETURN_OBJECT_FAILURE.equals(user.getLockState())) {
                // 账户被锁
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("账户被锁");
            } else if (!user.getAllowIps().contains(request.getRemoteAddr())) {
                // IP受限
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("IP受限");
            } else {
                // 登录成功
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
                obj.setMessage("登录成功");
            }
        }

        return obj;
    }

}
