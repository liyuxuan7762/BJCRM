package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.workbench.mapper.ActivityRemarkMapper;
import com.bjpowernode.crm.workbench.service.ActivityRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service("activityRemarkService")
public class ActivityRemarkServiceImpl implements ActivityRemarkService {

    @Autowired
    ActivityRemarkMapper mapper;

    @Override
    public List<ActivityRemark> queryActivityRemarkByActivityId(String activityId) {
        return  mapper.selectActivityRemarkByActivityId(activityId);
    }

    @Override
    public int saveCreateActivityRemark(ActivityRemark activityRemark) {
        return mapper.insertActivityRemark(activityRemark);
    }

    @Override
    public int deleteActivityRemarkById(String remarkId) {
        return mapper.deleteActivityRemark(remarkId);
    }

    @Override
    public int saveEditActivityRemark(ActivityRemark activityRemark) {
        return mapper.updateActivityRemark(activityRemark);
    }
}
