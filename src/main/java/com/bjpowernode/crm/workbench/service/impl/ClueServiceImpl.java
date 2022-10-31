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
    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private TranRemarkMapper tranRemarkMapper;
    @Autowired
    private TranHistoryMapper tranHistoryMapper;

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

        if (clueRemarkList != null && clueRemarkList.size() > 0) {
            // 将线索备注转化到客户备注 将线索备注转换到联系人备注
            List<ContactsRemark> contactsRemarkList = new ArrayList<>();
            List<CustomerRemark> customerRemarkList = new ArrayList<>();
            ContactsRemark contactsRemark = null;
            CustomerRemark customerRemark = null;
            for (ClueRemark cr : clueRemarkList) {
                contactsRemark = new ContactsRemark(UUIDUtils.getUUID(), cr.getNoteContent(), cr.getCreateBy(),
                        cr.getCreateTime(), cr.getEditBy(), cr.getEditTime(), cr.getEditFlag(), contacts.getId());
                customerRemark = new CustomerRemark(UUIDUtils.getUUID(), cr.getNoteContent(), cr.getCreateBy(),
                        cr.getCreateTime(), cr.getEditBy(), cr.getEditTime(), cr.getEditFlag(), customer.getId());
                contactsRemarkList.add(contactsRemark);
                customerRemarkList.add(customerRemark);
            }
            contactsRemarkMapper.insertContactsRemark(contactsRemarkList);
            customerRemarkMapper.insertCustomerRemark(customerRemarkList);
        }

        // 根据线索ID查询线索和市场活动关联关系并写入到联系人-市场活动关联表
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationMapper.selectRelationByClueId(clueId);

        if (clueActivityRelationList != null && clueActivityRelationList.size() > 0) {
            List<ContactsActivityRelation> contactsActivityRelationList = new ArrayList<>();
            ContactsActivityRelation contactsActivityRelation = null;
            for (ClueActivityRelation car : clueActivityRelationList) {
                contactsActivityRelation = new ContactsActivityRelation(UUIDUtils.getUUID(), contacts.getId(), car.getActivityId());
                contactsActivityRelationList.add(contactsActivityRelation);
            }
            contactsActivityRelationMapper.insertContactsActivityRelation(contactsActivityRelationList);
        }
        // 如果需要创建交易
        String isCreatedTransaction = (String) map.get("isCreatedTransaction");
        if ("true".equals(isCreatedTransaction)) {
            String money = (String) map.get("money");
            String name = (String) map.get("name");
            String expectedDate = (String) map.get("expectedDate");
            String stage = (String) map.get("stage");
            String activityId = (String) map.get("activityId");

            // 创建交易
            Tran tran = new Tran(UUIDUtils.getUUID(), user.getId(), money, name, expectedDate, customer.getId(), stage, "", clue.getSource(), activityId, contacts.getId(), user.getId(), DateUtils.getFormatDate(new Date()), clue.getDescription(), clue.getContactSummary(), clue.getNextContactTime());
            tranMapper.insertTran(tran);
            // 创建交易历史
            TranHistory tranHistory = new TranHistory(UUIDUtils.getUUID(), tran.getStage(), tran.getMoney(), tran.getExpectedDate(), tran.getCreateTime(), tran.getCreateBy(), tran.getId());
            tranHistoryMapper.insertSelective(tranHistory);


            if (clueRemarkList != null && clueRemarkList.size() > 0) {
                // 将备注信息转换到交易备注信息
                List<TranRemark> tranRemarkList = new ArrayList<>();
                TranRemark tranRemark = null;
                for (ClueRemark cr : clueRemarkList) {
                    tranRemark = new TranRemark(UUIDUtils.getUUID(), cr.getNoteContent(), cr.getCreateBy(),
                            cr.getCreateTime(), cr.getEditBy(), cr.getEditTime(), cr.getEditFlag(), tran.getId());
                    tranRemarkList.add(tranRemark);
                }
                tranRemarkMapper.insertTranRemark(tranRemarkList);
            }
        }

        // 删除线索下所有备注
        clueRemarkMapper.deleteClueRemarkById(clueId);
        // 删除所有关系
        clueActivityRelationMapper.deleteClueActivityRelationById(clueId);
        // 删除线索
        clueMapper.deleteClueById(clueId);

    }
}
