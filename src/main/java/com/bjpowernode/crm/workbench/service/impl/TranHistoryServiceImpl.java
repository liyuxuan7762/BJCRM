package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.mapper.TranHistoryMapper;
import com.bjpowernode.crm.workbench.service.TranHistoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("tranHistoryService")
public class TranHistoryServiceImpl implements TranHistoryService {

    @Autowired
    private TranHistoryMapper tranHistoryMapper;

    public int insertHistory(TranHistory tranHistory) {
        return tranHistoryMapper.insertTranHistory(tranHistory);
    }

    @Override
    public List<TranHistory> queryHistoryByTranId(String tranId) {
         return tranHistoryMapper.selectTranHistoryForDetailByTranId(tranId);
    }
}
