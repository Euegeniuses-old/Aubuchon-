package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class SalesModel implements Serializable {

    @SerializedName("product")
    private ArrayList<Product> product = null;

    @SerializedName("SalesByMonth")
    private ArrayList<SalesByMonth> salesByMonth = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public ArrayList<SalesByMonth> getSalesByMonth() {
        return salesByMonth;
    }

    public void setSalesByMonth(ArrayList<SalesByMonth> salesByMonth) {
        this.salesByMonth = salesByMonth;
    }

    public class Product {

        @SerializedName("store")
        private String store;

        @SerializedName("sku")
        private String sku;

        public String getStore() {
            return store;
        }

        public void setStore(String store) {
            this.store = store;
        }

        public String getSku() {
            return sku;
        }

        public void setSku(String sku) {
            this.sku = sku;
        }

    }

    public class SalesByMonth implements Serializable {

        @SerializedName("monstr")
        private String monstr;

        @SerializedName("yr")
        private int yr;

        @SerializedName("mon")
        private int mon;

        @SerializedName("storeQty")
        private int storeQty;

        @SerializedName("CompQty")
        private int compQty;

        @SerializedName("Sort")
        private int sort;

        public String getMonstr() {
            return monstr;
        }

        public void setMonstr(String monstr) {
            this.monstr = monstr;
        }

        public int getYr() {
            return yr;
        }

        public void setYr(int yr) {
            this.yr = yr;
        }

        public int getMon() {
            return mon;
        }

        public void setMon(int mon) {
            this.mon = mon;
        }

        public int getStoreQty() {
            return storeQty;
        }

        public void setStoreQty(int storeQty) {
            this.storeQty = storeQty;
        }

        public int getCompQty() {
            return compQty;
        }

        public void setCompQty(int compQty) {
            this.compQty = compQty;
        }

        public int getSort() {
            return sort;
        }

        public void setSort(int sort) {
            this.sort = sort;
        }

    }

}

