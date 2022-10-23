package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class ClueController {

    @Autowired
    private UserService userService;
    @Autowired
    private DicValueService dicValueService;
    @Autowired
    private ClueService clueService;

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
            if(result > 0) {
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
}

