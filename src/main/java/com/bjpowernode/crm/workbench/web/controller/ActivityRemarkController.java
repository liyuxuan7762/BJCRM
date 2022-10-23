package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.commons.constants.Constants;
import com.bjpowernode.crm.commons.domain.ReturnObj;
import com.bjpowernode.crm.commons.utils.DateUtils;
import com.bjpowernode.crm.commons.utils.UUIDUtils;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

@Controller
public class ActivityRemarkController {
    @Autowired
    private ActivityRemarkService activityRemarkService;

    @RequestMapping("/workbench/activity/addRemark.do")
    @ResponseBody
    public Object addRemark(ActivityRemark activityRemark, HttpSession session) {
        // 前端传递评论内容，市场活动ID
        // 后端封装 ID，创建者，创建时间，修改位
        activityRemark.setId(UUIDUtils.getUUID());
        User user = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        activityRemark.setCreateBy(user.getId());
        activityRemark.setCreateTime(DateUtils.getFormatDate(new Date()));
        activityRemark.setEditFlag(Constants.REMARK_EDIT_FLAG_NO_EDITED);

        ReturnObj obj = new ReturnObj();

        try {
            // 调用业务方法
            int result = activityRemarkService.saveCreateActivityRemark(activityRemark);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
                obj.setMessage("评论成功");
                obj.setRetData(activityRemark);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("评论失败");
            }
        } catch (Exception e) {
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("评论失败");
        }
        return obj;
    }

    // 删除市场活动评论
    @RequestMapping("/workbench/activity/deleteRemark.do")
    @ResponseBody
    public Object deleteRemark(String remarkId) {
        ReturnObj obj = new ReturnObj();
        try {
            int result = activityRemarkService.deleteActivityRemarkById(remarkId);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("系统繁忙.......");
            }
        } catch (Exception e) {
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统繁忙.......");
        }
        return obj;
    }

    // 修改评论
    @RequestMapping("/workbench/activity/editRemark.do")
    @ResponseBody
    public Object editRemark(ActivityRemark activityRemark, HttpSession session) {
        // 封装数据
        User user = (User) session.getAttribute(Constants.SESSION_USER_KEY);
        activityRemark.setEditBy(user.getId());
        activityRemark.setEditTime(DateUtils.getFormatDate(new Date()));
        activityRemark.setEditFlag(Constants.REMARK_EDIT_FLAG_EDITED);
        ReturnObj obj = new ReturnObj();
        try {
            int result = activityRemarkService.saveEditActivityRemark(activityRemark);
            if (result > 0) {
                obj.setCode(Constants.RETURN_OBJECT_SUCCESS);
                obj.setRetData(activityRemark);
            } else {
                obj.setCode(Constants.RETURN_OBJECT_FAILURE);
                obj.setMessage("系统繁忙.......");
            }
        } catch (Exception e) {
            obj.setCode(Constants.RETURN_OBJECT_FAILURE);
            obj.setMessage("系统繁忙.......");
        }
        return obj;

    }
}
