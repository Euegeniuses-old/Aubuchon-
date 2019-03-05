package com.developer.weatcb.model;

public class SalesHistoryModel {
    private String month;
    private int store;
    private int company;
    private int year;

    public SalesHistoryModel(String month, int store, int company, int year) {
        this.month = month;
        this.store = store;
        this.company = company;
        this.year = year;
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

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
