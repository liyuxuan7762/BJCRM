package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.mapper.ClueMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("clueService")
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper mapper;
    @Override
    public int saveClue(Clue clue) {
        return mapper.insert(clue);
    }

    @Override
    public Clue queryClueDetail(String id) {
        return mapper.selectClueDetail(id);
    }
}
