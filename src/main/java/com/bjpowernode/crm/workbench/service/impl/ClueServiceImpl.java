package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.mapper.ClueMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.StringReader;
import java.util.Date;
import java.util.Map;

@Service("clueService")
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper mapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Override
    public int saveClue(Clue clue) {
        return mapper.insert(clue);
    }

    @Override
    public Clue queryClueDetail(String id) {
        return mapper.selectClueDetail(id);
    }

    @Override
    public void convertClue(Map<String, Object> map) {
        // 获取参数
        // 根据ID查询出线索的信息
        String clueId = (String) map.get("clueId");
        Clue clue = mapper.selectClueById(clueId);
        // 把线索中有关公司的信息转换到客户表中
        Customer customer = new Customer();
        User user = (User) map.get(Constants.SESSION_USER_KEY);
        // 封装信息
        customer.setAddress(clue.getAddress());
        customer.setDescription(clue.getDescription());
        customer.setContactSummary(clue.getContactSummary());
        customer.setNextContactTime(clue.getNextContactTime());
        customer.setPhone(clue.getPhone());
        customer.setWebsite(clue.getWebsite());
        customer.setName(clue.getFullname());
        customer.setId(UUIDUtils.getUUID());
        customer.setCreateBy(user.getId());
        customer.setCreateTime(DateUtils.getFormatDate(new Date()));
        customer.setOwner(user.getId());
        // 保存客户信息
        customerMapper.insertCustomer(customer);

    }
}
