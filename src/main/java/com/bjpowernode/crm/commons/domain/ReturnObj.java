package com.bjpowernode.crm.commons.domain;

// 这个类用于封装Json返回数据
public class ReturnObj {
    public String code;
    public String message;

    public Object retData;

    public ReturnObj() {
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getRetData() {
        return retData;
    }

    public void setRetData(Object retData) {
        this.retData = retData;
    }
}
