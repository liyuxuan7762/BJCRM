package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper mapper;

    @Override
    public User queryUserByLoginActAndPwd(Map<String, Object> map) {
        return mapper.getUserByLoginActAndPwd(map);
    }

    @Override
    public List<User> queryAllUsers() {
        return mapper.selectAllUsers();
    }
}
