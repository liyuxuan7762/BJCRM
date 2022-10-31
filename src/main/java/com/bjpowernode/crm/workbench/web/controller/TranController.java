package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.domain.TranRemark;
import com.bjpowernode.crm.workbench.mapper.TranHistoryMapper;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.bjpowernode.crm.workbench.service.TranHistoryService;
import com.bjpowernode.crm.workbench.service.TranRemarkService;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

@Controller
public class TranController {
    @Autowired
    private DicValueService dicValueService;
    @Autowired
    private UserService userService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private TranService tranService;
    @Autowired
    private TranHistoryService tranHistoryService;
    @Autowired
    private TranRemarkService tranRemarkService;

    // 跳转交易主界面
    @RequestMapping("workbench/transaction/index.do")
    public String index(HttpServletRequest request) {
        // 类型 阶段 来源
        List<DicValue> transactionType = dicValueService.queryDicValueByTypeCode("transactionType");
        List<DicValue> stage = dicValueService.queryDicValueByTypeCode("stage");
        List<DicValue> source = dicValueService.queryDicValueByTypeCode("source");

        request.setAttribute("transactionType", transactionType);
        request.setAttribute("stage", stage);
        request.setAttribute("source", source);

        return "workbench/transaction/index";
    }

    // 跳转创建交易
    @RequestMapping("/workbench/transaction/save.do")
    public String save(HttpServletRequest request) {

        List<User> userList = userService.queryAllUsers();
        List<DicValue> transactionType = dicValueService.queryDicValueByTypeCode("transactionType");
        List<DicValue> stage = dicValueService.queryDicValueByTypeCode("stage");
        List<DicValue> source = dicValueService.queryDicValueByTypeCode("source");


        request.setAttribute("transactionType", transactionType);
        request.setAttribute("stage", stage);
        request.setAttribute("source", source);
        request.setAttribute("userList", userList);

        return "workbench/transaction/save";
    }

    // 实现读取用户配置文件查询可能性
    @RequestMapping("/workbench/transaction/queryPossibility.do")
    @ResponseBody
    public Object queryPossibility(String stageName) {
        ResourceBundle resourceBundle = ResourceBundle.getBundle("poss");
        String res = resourceBundle.getString(stageName);
        return res;
    }

    // 查询客户全称
    @RequestMapping("/workbench/transaction/queryCustomerName.do")
    @ResponseBody
    public Object queryCustomerName(String customerName) {
        List<String> nameList = customerService.queryCustomerNameByName(customerName);
        return nameList;
    }

    // 创建交易
    @RequestMapping("/workbench/transaction/saveTran.do")
    @ResponseBody
    public Object saveTran(@RequestParam Map<String, Object> map, HttpSession session) {
        // 封装剩余参数
        map.put(Constants.SESSION_USER_KEY, session.getAttribute(Constants.SESSION_USER_KEY));
        ReturnObj obj = new ReturnObj();
        try {
            tranService.saveTran(map);
            obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
        } catch (Exception e) {
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统繁忙.......");
        }
        return obj;
    }

    // 查询交易详情
    @RequestMapping("/workbench/transaction/tranDetail.do")
    public String tranDetail(String tranId, HttpServletRequest request) {
        Tran tran = tranService.queryTranById(tranId);
        List<TranRemark> remarkList = tranRemarkService.queryRemarkByTranId(tranId);
        List<TranHistory> tranHistoryList = tranHistoryService.queryHistoryByTranId(tranId);
        List<DicValue> stageList = dicValueService.queryAllStage();

        ResourceBundle resourceBundle = ResourceBundle.getBundle("poss");
        String possibility = resourceBundle.getString(tran.getStage());

        String orderNo = dicValueService.queryOrderNoByValue(tran.getStage());


        request.setAttribute("tran", tran);
        request.setAttribute("remarkList", remarkList);
        request.setAttribute("tranHistoryList", tranHistoryList);
        request.setAttribute("stageList", stageList);
        tran.setOrderNo(orderNo);
        tran.setPossibility(possibility);

        return "workbench/transaction/detail";
    }
}
