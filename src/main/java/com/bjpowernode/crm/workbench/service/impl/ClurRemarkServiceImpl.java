package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.ClueRemark;
import com.bjpowernode.crm.workbench.mapper.ClueRemarkMapper;
import com.bjpowernode.crm.workbench.service.ClueRemarkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("clueRemarkService")
public class ClurRemarkServiceImpl implements ClueRemarkService {

    @Autowired
    ClueRemarkMapper mapper;

    @Override
    public List<ClueRemark> selectClueRemarkById(String id) {
        return mapper.selectClueRemark(id);
    }
}
