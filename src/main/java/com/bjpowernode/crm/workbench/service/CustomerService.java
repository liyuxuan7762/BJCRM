package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Customer;

import java.util.List;

public interface CustomerService {
    // 根据名称模糊查询名称
    List<String> queryCustomerNameByName(String name);

    // 根据名称精确查找
    Customer queryCustomerByName(String name);
}
