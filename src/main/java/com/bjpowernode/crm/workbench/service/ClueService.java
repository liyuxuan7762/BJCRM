package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Clue;


public interface ClueService {
    // 插入一条线索
    int saveClue(Clue clue);

    Clue queryClueDetail(String id);
}
