package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    // 保存插入的活动
    int saveCreatActivity(Activity activity);

    // 根据条件进行分页查询市场活动
    List<Activity> queryActivityByConditionForPage(Map<String, Object> map);

    // 根据条件查询市场活动总条数
    int queryActivityTotalRowByCondition(Map<String, Object> map);
}
