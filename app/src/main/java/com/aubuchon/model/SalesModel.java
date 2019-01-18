package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class SalesModel implements Serializable
{
    @SerializedName("product")
    private ArrayList<Product> product = null;

    @SerializedName("StoresByMonth")
    private ArrayList<StoresByMonth> storesByMonth = null;

    @SerializedName("CompanyByMonth")
    private ArrayList<CompanyByMonth> companyByMonth = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public ArrayList<StoresByMonth> getStoresByMonth() {
        return storesByMonth;
    }

    public void setStoresByMonth(ArrayList<StoresByMonth> storesByMonth) {
        this.storesByMonth = storesByMonth;
    }

    public ArrayList<CompanyByMonth> getCompanyByMonth() {
        return companyByMonth;
    }

    public void setCompanyByMonth(ArrayList<CompanyByMonth> companyByMonth) {
        this.companyByMonth = companyByMonth;
    }


    public class Product implements Serializable {
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

    public class StoresByMonth implements Serializable {
        @SerializedName("qty")
        private int qty;

        @SerializedName("monStr")
        private String monStr;

        @SerializedName("mon")
        private int mon;

        @SerializedName("yr")
        private int yr;

        public int getQty() {
            return qty;
        }

        public void setQty(int qty) {
            this.qty = qty;
        }

        public String getMonStr() {
            return monStr;
        }

        public void setMonStr(String monStr) {
            this.monStr = monStr;
        }

        public int getMon() {
            return mon;
        }

        public void setMon(int mon) {
            this.mon = mon;
        }

        public int getYr() {
            return yr;
        }

        public void setYr(int yr) {
            this.yr = yr;
        }

    }

    public class CompanyByMonth implements Serializable {
        @SerializedName("qty")
        private int qty;

        @SerializedName("monStr")
        private String monStr;

        @SerializedName("mon")
        private int mon;

        @SerializedName("yr")
        private int yr;

        public int getQty() {
            return qty;
        }

        public void setQty(int qty) {
            this.qty = qty;
        }

        public String getMonStr() {
            return monStr;
        }

        public void setMonStr(String monStr) {
            this.monStr = monStr;
        }

        public int getMon() {
            return mon;
        }

        public void setMon(int mon) {
            this.mon = mon;
        }

        public int getYr() {
            return yr;
        }

        public void setYr(int yr) {
            this.yr = yr;
        }

    }

}


