package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("customerService")
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerMapper mapper;
    @Override
    public List<String> queryCustomerNameByName(String name) {
        return mapper.queryCustomerNameByName(name);
    }

    @Override
    public Customer queryCustomerByName(String name) {
        return mapper.queryCustomerByName(name);
    }
}
