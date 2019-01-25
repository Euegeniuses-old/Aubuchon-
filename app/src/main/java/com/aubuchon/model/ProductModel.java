package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class ProductModel implements Serializable {

    @SerializedName("product")
    private ArrayList<Product> product = null;

    @SerializedName("Table1")
    private ArrayList<Table1> table1 = null;

    @SerializedName("Table2")
    private ArrayList<Table2> table2 = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public ArrayList<Table1> getTable1() {
        return table1;
    }

    public void setTable1(ArrayList<Table1> table1) {
        this.table1 = table1;
    }

    public ArrayList<Table2> getTable2() {
        return table2;
    }

    public void setTable2(ArrayList<Table2> table2) {
        this.table2 = table2;
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
        private Double retailPrice;

        @SerializedName("imageURL")
        private String imageURL;

        @SerializedName("companyYrSales")
        private Integer companyYrSales;

        @SerializedName("storeYrSales")
        private Integer storeYrSales;

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
        private Integer onHandAmt;

        @SerializedName("available")
        private Integer available;

        @SerializedName("onOrderAmt")
        private Integer onOrderAmt;

        @SerializedName("onOrderPO")
        private String onOrderPO;

        @SerializedName("deliveryDate")
        private String deliveryDate;

        @SerializedName("url_key")
        private String urlKey;

        @SerializedName("minStk")
        private Integer minStk;

        @SerializedName("maxStk")
        private Integer maxStk;

        @SerializedName("reOrdPoint")
        private Integer reOrdPoint;

        @SerializedName("rating")
        private Float rating;


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

        public Double getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(Double retailPrice) {
            this.retailPrice = retailPrice;
        }

        public String getImageURL() {
            return imageURL;
        }

        public void setImageURL(String imageURL) {
            this.imageURL = imageURL;
        }

        public Integer getCompanyYrSales() {
            return companyYrSales;
        }

        public void setCompanyYrSales(Integer companyYrSales) {
            this.companyYrSales = companyYrSales;
        }

        public Integer getStoreYrSales() {
            return storeYrSales;
        }

        public void setStoreYrSales(Integer storeYrSales) {
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

        public Integer getOnHandAmt() {
            return onHandAmt;
        }

        public void setOnHandAmt(Integer onHandAmt) {
            this.onHandAmt = onHandAmt;
        }

        public Integer getAvailable() {
            return available;
        }

        public void setAvailable(Integer available) {
            this.available = available;
        }

        public Integer getOnOrderAmt() {
            return onOrderAmt;
        }

        public void setOnOrderAmt(Integer onOrderAmt) {
            this.onOrderAmt = onOrderAmt;
        }

        public String getOnOrderPO() {
            return onOrderPO;
        }

        public void setOnOrderPO(String onOrderPO) {
            this.onOrderPO = onOrderPO;
        }

        public String getDeliveryDate() {
            return deliveryDate;
        }

        public void setDeliveryDate(String deliveryDate) {
            this.deliveryDate = deliveryDate;
        }

        public String getUrlKey() {
            return urlKey;
        }

        public void setUrlKey(String urlKey) {
            this.urlKey = urlKey;
        }

        public Integer getMinStk() {
            return minStk;
        }

        public void setMinStk(Integer minStk) {
            this.minStk = minStk;
        }

        public Integer getMaxStk() {
            return maxStk;
        }

        public void setMaxStk(Integer maxStk) {
            this.maxStk = maxStk;
        }

        public Integer getReOrdPoint() {
            return reOrdPoint;
        }

        public void setReOrdPoint(Integer reOrdPoint) {
            this.reOrdPoint = reOrdPoint;
        }

        public Float getRating() {
            return rating;
        }

        public void setRating(Float rating) {
            this.rating = rating;
        }
    }

    public class Table1 implements Serializable{

        @SerializedName("altUPC")
        private String altUPC;

        @SerializedName("Primary")
        private Boolean primary;

        public String getAltUPC() {
            return altUPC;
        }

        public void setAltUPC(String altUPC) {
            this.altUPC = altUPC;
        }

        public Boolean getPrimary() {
            return primary;
        }

        public void setPrimary(Boolean primary) {
            this.primary = primary;
        }

    }

    public static class Table2 implements Serializable{

        @SerializedName("poNo")
        private String poNo;

        @SerializedName("orderQty")
        private int orderQty;

        @SerializedName("delDate")
        private String delDate;

        public String getPoNo() {
            return poNo;
        }

        public void setPoNo(String poNo) {
            this.poNo = poNo;
        }

        public int getOrderQty() {
            return orderQty;
        }

        public void setOrderQty(int orderQty) {
            this.orderQty = orderQty;
        }

        public String getDelDate() {
            return delDate;
        }

        public void setDelDate(String delDate) {
            this.delDate = delDate;
        }
    }

}