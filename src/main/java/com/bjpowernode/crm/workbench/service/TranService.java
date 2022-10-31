package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.funnelChartVO;

import java.util.List;
import java.util.Map;

public interface TranService {
    void saveTran(Map<String, Object> map);

    Tran queryTranById(String id);

    // 查询各个阶段的交易数量
    List<funnelChartVO> queryForFunnel();
}
