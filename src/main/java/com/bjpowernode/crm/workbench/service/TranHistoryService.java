package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;

public interface TranHistoryService {
    int insertHistory(TranHistory tranHistory);

    List<TranHistory> queryHistoryByTranId(String tranId);
}
