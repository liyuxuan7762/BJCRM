package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.domain.funnelChartVO;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.TranHistoryMapper;
import com.bjpowernode.crm.workbench.mapper.TranMapper;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;

@Service("tranService")
public class TranServiceImpl implements TranService {
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    @Override
    public void saveTran(Map<String, Object> map) {
        String customerName = (String) map.get("customerName");
        User user = (User) map.get(Constants.SESSION_USER_KEY);
        Customer customer = customerMapper.queryCustomerByName(customerName);
        // 如果客户名称不存在需要创建一个客户
        if (customer == null) {
            customer = new Customer(UUIDUtils.getUUID(), user.getId(), customerName, user.getId(), DateUtils.getFormatDate(new Date()));
            customerMapper.insertSelective(customer);
        }

        // 创建交易
        Tran tran = new Tran(UUIDUtils.getUUID(), user.getId(), (String) map.get("money"), (String) map.get("name"),
                (String) map.get("expectedDate"), customer.getId(), (String) map.get("stage"), (String) map.get("type"),
                (String) map.get("source"), (String) map.get("activityId"), (String) map.get("contactsId"), user.getId(),
                DateUtils.getFormatDate(new Date()), (String) map.get("description"), (String) map.get("contactSummary"),
                (String) map.get("nextContactTime"));
        tranMapper.insertTran(tran);
        // 创建交易历史
        TranHistory tranHistory = new TranHistory(UUIDUtils.getUUID(), tran.getStage(), tran.getMoney(), tran.getExpectedDate(), tran.getCreateTime(), tran.getCreateBy(), tran.getId());
        tranHistoryMapper.insertSelective(tranHistory);

    }

    @Override
    public Tran queryTranById(String id) {
        return tranMapper.selectTranById(id);
    }

    @Override
    public List<funnelChartVO> queryForFunnel() {
        return tranMapper.selectForFunnel();
    }
}
