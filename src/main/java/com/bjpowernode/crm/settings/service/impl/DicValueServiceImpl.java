package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.mapper.DicValueMapper;
import com.bjpowernode.crm.settings.service.DicValueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("dicValueService")
public class DicValueServiceImpl implements DicValueService {

    @Autowired
    private DicValueMapper mapper;

    @Override
    public List<DicValue> queryDicValueByTypeCode(String typeCode) {
        return mapper.selectDicValueByTypeCode(typeCode);
    }

    @Override
    public String queryOrderNoByValue(String value) {
        return mapper.selectOrderNoByValue(value);
    }

    @Override
    public List<DicValue> queryAllStage() {
        return mapper.selectAllStage();
    }
}
