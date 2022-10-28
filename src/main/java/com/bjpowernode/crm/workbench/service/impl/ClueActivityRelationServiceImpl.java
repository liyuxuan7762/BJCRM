package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;
import com.bjpowernode.crm.workbench.mapper.ClueActivityRelationMapper;
import com.bjpowernode.crm.workbench.service.ClueActivityRelationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("clueActivityRelationService")
public class ClueActivityRelationServiceImpl implements ClueActivityRelationService {
    @Autowired
    private ClueActivityRelationMapper mapper;

    /**
     * 批量插入市场活动-线索关系
     *
     * @param clueActivityRelationList
     * @return
     */
    @Override
    public int saveCreateActivityClueRelationByActivityIdAndClueId(List<ClueActivityRelation> clueActivityRelationList) {
        return mapper.insertActivityClueRelationByActivityIdAndClueId(clueActivityRelationList);
    }

    @Override
    public int deleteRelationByActivityAndClueId(ClueActivityRelation clueActivityRelation) {
        return mapper.deleteRelationByActivityAndClueId(clueActivityRelation);
    }


}
