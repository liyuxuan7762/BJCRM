package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.ClueRemark;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.service.ClueRemarkService;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedCaseInsensitiveMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class ClueController {

    @Autowired
    private UserService userService;
    @Autowired
    private DicValueService dicValueService;
    @Autowired
    private ClueService clueService;
    @Autowired
    private ClueRemarkService clueRemarkService;
    @Autowired
    private ActivityService activityService;

    // 接收用户请求，将所有下拉列表值查出来，然后通过作用域传递到前台并跳转页面
    @RequestMapping("/workbench/clue/index.do")
    public String index(HttpServletRequest request) {
        // 查询所有用户信息
        List<User> userList = userService.queryAllUsers();
        // 查询称呼
        List<DicValue> appellationList = dicValueService.queryDicValueByTypeCode("appellation");
        // 查询线索状态
        List<DicValue> clueStateList = dicValueService.queryDicValueByTypeCode("clueState");
        // 查询线索来源
        List<DicValue> sourceList = dicValueService.queryDicValueByTypeCode("source");

        // 放入作用域中
        request.setAttribute("userList", userList);
        request.setAttribute("appellationList", appellationList);
        request.setAttribute("clueStateList", clueStateList);
        request.setAttribute("sourceList", sourceList);

        // 请求转发
        return "workbench/clue/index";


    }

    // 插入线索
    @RequestMapping("/workbench/clue/saveClue.do")
    @ResponseBody
    public Object saveClue(Clue clue, HttpSession session) {
        // 封装剩余参数
        clue.setId(UUIDUtils.getUUID());
        User user = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        clue.setCreateBy(user.getId());
        clue.setCreateTime(DateUtils.getFormatDate(new Date()));
        ReturnObj obj = new ReturnObj();
        // 调用业务层方法
        try {
            int result = clueService.saveClue(clue);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("系统繁忙.........");
            }
        } catch (Exception e) {
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统繁忙.........");
        }

        return obj;
    }

    // 显示线索详细信息
    @RequestMapping("/workbench/clue/clueDetail.do")
    public String clueDetail(String clueId, HttpServletRequest request) {
        // 查询线索详情
        Clue clue = clueService.queryClueDetail(clueId);
        // 查询线索评论
        List<ClueRemark> remarkList = clueRemarkService.selectClueRemarkById(clueId);
        // 查询关联的市场活动
        List<Activity> activityList = activityService.queryActivityByClueId(clueId);
        request.setAttribute("clue", clue);
        request.setAttribute("remarkList", remarkList);
        request.setAttribute("activityList", activityList);
        return "workbench/clue/detail";
    }

    // 实现用户关联市场活动的实时刷新
    @RequestMapping("/workbench/clue/searchActivityByActivityNameAndClueId.do")
    @ResponseBody
    public Object searchActivityByActivityNameAndClueId(String activityName, String clueId) {
        // 1.封装参数
        Map<String, Object> map = new HashMap<>();
        map.put("activityName", activityName);
        map.put("clueId", clueId);
        // 查询
        return activityService.queryActivityExcludeByClueId(map);
    }

}

