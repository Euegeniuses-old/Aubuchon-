package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class ProductModel implements Serializable {

    @SerializedName("product")
    private ArrayList<Product> product = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public class Product implements Serializable {

        @SerializedName("store")
        private String store;

        @SerializedName("sku")
        private String sku;

        @SerializedName("webDesc")
        private String webDesc;

        @SerializedName("posDesc")
        private String posDesc;

        @SerializedName("departmentName")
        private String departmentName;

        @SerializedName("className")
        private String className;

        @SerializedName("subClassName")
        private String subClassName;

        @SerializedName("section")
        private String section;

        @SerializedName("sectionDesc")
        private String sectionDesc;

        @SerializedName("speedNo")
        private String speedNo;

        @SerializedName("ordUnit")
        private String ordUnit;

        @SerializedName("discDate")
        private String discDate;

        @SerializedName("prodStatus")
        private String prodStatus;

        @SerializedName("retailPrice")
        private double retailPrice;

        @SerializedName("imageURL")
        private String imageURL;

        @SerializedName("companyYrSales")
        private int companyYrSales;

        @SerializedName("storeYrSales")
        private int storeYrSales;

        @SerializedName("supplier")
        private String supplier;

        @SerializedName("supplierName")
        private String supplierName;

        @SerializedName("promoPrice")
        private String promoPrice;

        @SerializedName("lastSoldDate")
        private String lastSoldDate;

        @SerializedName("lastDelDate")
        private String lastDelDate;

        @SerializedName("onHandAmt")
        private int onHandAmt;

        @SerializedName("available")
        private int available;

        @SerializedName("onOrderAmt")
        private int onOrderAmt;

        @SerializedName("onOrderPO")
        private String onOrderPO;

        @SerializedName("url_key")
        private String urlKey;

        @SerializedName("minStk")
        private int minStk;

        @SerializedName("maxStk")
        private int maxStk;

        @SerializedName("reOrdPoint")
        private int reOrdPoint;

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

        public String getWebDesc() {
            return webDesc;
        }

        public void setWebDesc(String webDesc) {
            this.webDesc = webDesc;
        }

        public String getPosDesc() {
            return posDesc;
        }

        public void setPosDesc(String posDesc) {
            this.posDesc = posDesc;
        }

        public String getDepartmentName() {
            return departmentName;
        }

        public void setDepartmentName(String departmentName) {
            this.departmentName = departmentName;
        }

        public String getClassName() {
            return className;
        }

        public void setClassName(String className) {
            this.className = className;
        }

        public String getSubClassName() {
            return subClassName;
        }

        public void setSubClassName(String subClassName) {
            this.subClassName = subClassName;
        }

        public String getSection() {
            return section;
        }

        public void setSection(String section) {
            this.section = section;
        }

        public String getSectionDesc() {
            return sectionDesc;
        }

        public void setSectionDesc(String sectionDesc) {
            this.sectionDesc = sectionDesc;
        }

        public String getSpeedNo() {
            return speedNo;
        }

        public void setSpeedNo(String speedNo) {
            this.speedNo = speedNo;
        }

        public String getOrdUnit() {
            return ordUnit;
        }

        public void setOrdUnit(String ordUnit) {
            this.ordUnit = ordUnit;
        }

        public String getDiscDate() {
            return discDate;
        }

        public void setDiscDate(String discDate) {
            this.discDate = discDate;
        }

        public String getProdStatus() {
            return prodStatus;
        }

        public void setProdStatus(String prodStatus) {
            this.prodStatus = prodStatus;
        }

        public double getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(double retailPrice) {
            this.retailPrice = retailPrice;
        }

        public String getImageURL() {
            return imageURL;
        }

        public void setImageURL(String imageURL) {
            this.imageURL = imageURL;
        }

        public int getCompanyYrSales() {
            return companyYrSales;
        }

        public void setCompanyYrSales(int companyYrSales) {
            this.companyYrSales = companyYrSales;
        }

        public int getStoreYrSales() {
            return storeYrSales;
        }

        public void setStoreYrSales(int storeYrSales) {
            this.storeYrSales = storeYrSales;
        }

        public String getSupplier() {
            return supplier;
        }

        public void setSupplier(String supplier) {
            this.supplier = supplier;
        }

        public String getSupplierName() {
            return supplierName;
        }

        public void setSupplierName(String supplierName) {
            this.supplierName = supplierName;
        }

        public String getPromoPrice() {
            return promoPrice;
        }

        public void setPromoPrice(String promoPrice) {
            this.promoPrice = promoPrice;
        }

        public String getLastSoldDate() {
            return lastSoldDate;
        }

        public void setLastSoldDate(String lastSoldDate) {
            this.lastSoldDate = lastSoldDate;
        }

        public String getLastDelDate() {
            return lastDelDate;
        }

        public void setLastDelDate(String lastDelDate) {
            this.lastDelDate = lastDelDate;
        }

        public int getOnHandAmt() {
            return onHandAmt;
        }

        public void setOnHandAmt(int onHandAmt) {
            this.onHandAmt = onHandAmt;
        }

        public int getAvailable() {
            return available;
        }

        public void setAvailable(int available) {
            this.available = available;
        }

        public int getOnOrderAmt() {
            return onOrderAmt;
        }

        public void setOnOrderAmt(int onOrderAmt) {
            this.onOrderAmt = onOrderAmt;
        }

        public String getOnOrderPO() {
            return onOrderPO;
        }

        public void setOnOrderPO(String onOrderPO) {
            this.onOrderPO = onOrderPO;
        }

        public String getUrlKey() {
            return urlKey;
        }

        public void setUrlKey(String urlKey) {
            this.urlKey = urlKey;
        }

        public int getMinStk() {
            return minStk;
        }

        public void setMinStk(int minStk) {
            this.minStk = minStk;
        }

        public int getMaxStk() {
            return maxStk;
        }

        public void setMaxStk(int maxStk) {
            this.maxStk = maxStk;
        }

        public int getReOrdPoint() {
            return reOrdPoint;
        }

        public void setReOrdPoint(int reOrdPoint) {
            this.reOrdPoint = reOrdPoint;
        }

    }
}



