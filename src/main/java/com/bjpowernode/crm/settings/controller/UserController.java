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

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
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
    public Object login(String loginAct, String loginPwd, String isRemPwd, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
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
                session.setAttribute(Constants.SESSION_USER_KEY, user);

                // 当用户登录成功后，需要判断是否选中记住密码
                // 如果选中记住密码，则需要将密码写入cookie
                if ("true".equals(isRemPwd)) {
                    // 用户选中记住密码
                    Cookie c1 = new Cookie("loginAct", loginAct);
                    c1.setMaxAge(10 * 24 * 3600);
                    response.addCookie(c1);
                    Cookie c2 = new Cookie("loginPwd", loginPwd);
                    c2.setMaxAge(10 * 24 * 3600);
                    response.addCookie(c2);
                } else {
                    // 如果没选择记住密码，也需要将原来保存在客户端的cookie删除
                    // 删除方式是将cookie有效期设置为0
                    clearCookie(response);
                }
            }
        }

        return obj;
    }

    @RequestMapping("/settings/qx/user/loginOut.do")
    public String loginOut(HttpServletResponse response, HttpSession session) {
        // 实现用户的安全退出，清空cookie和session
        clearCookie(response);
        session.invalidate();
        return "redirect:/";
        // 为什么使用redirect 是因为我们返回后需要将url显示为登录页面的url
        // 如果使用forward 那么url还是login.do的url，那么用户一点击浏览器刷新
        // 就会再次执行退出操作 不符合逻辑
    }

    private void clearCookie(HttpServletResponse response) {
        Cookie c1 = new Cookie("loginAct", null);
        c1.setMaxAge(0);
        response.addCookie(c1);
        Cookie c2 = new Cookie("loginPwd", null);
        c2.setMaxAge(0);
        response.addCookie(c2);
    }
}
