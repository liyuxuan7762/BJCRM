package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("activityService")
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityMapper mapper;

    @Override
    public int saveCreatActivity(Activity activity) {
        return mapper.insertActivity(activity);
    }

    @Override
    public List<Activity> queryActivityByConditionForPage(Map<String, Object> map) {
        return mapper.selectActivityByConditionForPage(map);
    }

    @Override
    public int queryActivityTotalRowByCondition(Map<String, Object> map) {
        return mapper.selectActivityTotalRowByCondition(map);
    }

    @Override
    public int deleteActivityByIds(String[] ids) {
        return mapper.deleteActivityByIds(ids);
    }

    @Override
    public Activity queryActivityById(String id) {
        return mapper.selectActivityById(id);
    }

    @Override
    public int updateActivity(Activity activity) {
        return mapper.updateActivity(activity);
    }

    @Override
    public List<Activity> queryAllActivities() {
        return mapper.selectAllActivities();
    }
}
