package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Clue;

import java.util.Map;


public interface ClueService {
    // 插入一条线索
    int saveClue(Clue clue);

    Clue queryClueDetail(String id);

    // 转换线索
    void convertClue(Map<String, Object> map);


}
