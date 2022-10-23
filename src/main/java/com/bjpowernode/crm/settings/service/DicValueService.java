package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueService {
    // 根据TypeCode查询下拉列表的值
    List<DicValue> queryDicValueByTypeCode(String typeCode);
}
