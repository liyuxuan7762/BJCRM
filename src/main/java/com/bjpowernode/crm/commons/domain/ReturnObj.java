package com.bjpowernode.crm.commons.domain;

// 这个类用于封装Json返回数据
public class ReturnObj {
    public String code;
    public String message;

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
}
