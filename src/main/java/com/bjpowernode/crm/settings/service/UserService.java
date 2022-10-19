package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    User queryUserByLoginActAndPwd(Map<String, Object> map);

    // 查询所有用户
    List<User> queryAllUsers();

    // 根据姓名查询用户
    User queryUserByName(String name);
}
