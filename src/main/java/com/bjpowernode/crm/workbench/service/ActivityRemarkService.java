package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkService {
    List<ActivityRemark> queryActivityRemarkByActivityId(String activityId);

    // 插入一条市场活动评论
    int saveCreateActivityRemark(ActivityRemark activityRemark);


    int deleteActivityRemarkById(String remarkId);

    // 修改市场活动评论
    int saveEditActivityRemark(ActivityRemark activityRemark);
}
