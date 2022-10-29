package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("clueService")
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper clueMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private ClueRemarkMapper clueRemarkMapper;
    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;
    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;
    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;

    @Override
    public int saveClue(Clue clue) {
        return clueMapper.insert(clue);
    }

    @Override
    public Clue queryClueDetail(String id) {
        return clueMapper.selectClueDetail(id);
    }

    @Override
    public void convertClue(Map<String, Object> map) {
        // 获取参数
        // 根据ID查询出线索的信息
        String clueId = (String) map.get("clueId");
        Clue clue = clueMapper.selectClueById(clueId);
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
        customer.setName(clue.getCompany());
        customer.setId(UUIDUtils.getUUID());
        customer.setCreateBy(user.getId());
        customer.setCreateTime(DateUtils.getFormatDate(new Date()));
        customer.setOwner(user.getId());
        // 保存客户信息
        customerMapper.insertCustomer(customer);

        // 保存联系人信息
        Contacts contacts = new Contacts(UUIDUtils.getUUID(), user.getId(), clue.getSource(), customer.getId(), clue.getFullname(), clue.getAppellation(),
                clue.getEmail(), clue.getMphone(), clue.getJob(), user.getId(), DateUtils.getFormatDate(new Date()), clue.getDescription(), clue.getContactSummary(),
                clue.getNextContactTime(), clue.getAddress());
        contactsMapper.insertContact(contacts);

        // 根据线索Id查询所有的备注
        List<ClueRemark> clueRemarkList = clueRemarkMapper.selectClueRemarkById(clueId);

        // 将线索备注转化到客户备注 将线索备注转换到联系人备注
        List<ContactsRemark> contactsRemarkList = new ArrayList<>();
        List<CustomerRemark> customerRemarkList = new ArrayList<>();
        for(ClueRemark cr : clueRemarkList) {
            ContactsRemark contactsRemark = new ContactsRemark(UUIDUtils.getUUID(), cr.getNoteContent(), cr.getCreateBy(),
                    cr.getCreateTime(), cr.getEditBy(), cr.getEditTime(), cr.getEditFlag(), contacts.getId());
            CustomerRemark customerRemark = new CustomerRemark(UUIDUtils.getUUID(), cr.getNoteContent(), cr.getCreateBy(),
                    cr.getCreateTime(), cr.getEditBy(), cr.getEditTime(), cr.getEditFlag(), customer.getId());
            contactsRemarkList.add(contactsRemark);
            customerRemarkList.add(customerRemark);
        }
        contactsRemarkMapper.insertContactsRemark(contactsRemarkList);
        customerRemarkMapper.insertCustomerRemark(customerRemarkList);

        // 根据线索ID查询线索和市场活动关联关系并写入到联系人-市场活动关联表

    }
}
