package com.aubuchon.model;

public class SalesHistoryModel {
    private String month;
    private int store;
    private int company;

    public SalesHistoryModel(String month, int store, int company) {
        this.month = month;
        this.store = store;
        this.company = company;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public int getStore() {
        return store;
    }

    public void setStore(int store) {
        this.store = store;
    }

    public int getCompany() {
        return company;
    }

    public void setCompany(int company) {
        this.company = company;
    }
}
