package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueActivityRelationService {
    // 批量插入市场活动-线索关系
    int saveCreateActivityClueRelationByActivityIdAndClueId(List<ClueActivityRelation> clueActivityRelationList);

    int deleteRelationByActivityAndClueId(ClueActivityRelation clueActivityRelation);
}
