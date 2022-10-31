package com.bjpowernode.crm.workbench.domain;

public class funnelChartVO {
    private String name;
    private int value;

    public funnelChartVO() {
    }

    public funnelChartVO(String name, int value) {
        this.name = name;
        this.value = value;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }
}
