package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.util.ArrayList;

public class ProductDetailsModel {

    @SerializedName("product") /* Mapping with Inquiry Screen Data*/
    private ArrayList<Product> product = null;

    @SerializedName("StoresByMonth") /* Mapping with Sales History Screen STORE 170 */
    private ArrayList<StoresByMonth> storesByMonth = null;

    @SerializedName("CompanyByMonth") /* Mapping with Sales History Screen COMPANY*/
    private ArrayList<CompanyByMonth> companyByMonth = null;

    @SerializedName("StoreStock") /*Mapping with Local Inv Screen Data*/
    private ArrayList<StoreStock> storeStock = null;

    @SerializedName("RelatedProducts") /*Mapping with Related Screen*/
    private ArrayList<RelatedProduct> relatedProducts = null;

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

    public ArrayList<StoreStock> getStoreStock() {
        return storeStock;
    }

    public void setStoreStock(ArrayList<StoreStock> storeStock) {
        this.storeStock = storeStock;
    }

    public ArrayList<RelatedProduct> getRelatedProducts() {
        return relatedProducts;
    }

    public void setRelatedProducts(ArrayList<RelatedProduct> relatedProducts) {
        this.relatedProducts = relatedProducts;
    }

    public class Product {

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

    }

    public class StoresByMonth {

        @SerializedName("qty")
        private Integer qty;

        @SerializedName("monStr")
        private String monStr;

        @SerializedName("mon")
        private Integer mon;

        @SerializedName("yr")
        private Integer yr;

        public Integer getQty() {
            return qty;
        }

        public void setQty(Integer qty) {
            this.qty = qty;
        }

        public String getMonStr() {
            return monStr;
        }

        public void setMonStr(String monStr) {
            this.monStr = monStr;
        }

        public Integer getMon() {
            return mon;
        }

        public void setMon(Integer mon) {
            this.mon = mon;
        }

        public Integer getYr() {
            return yr;
        }

        public void setYr(Integer yr) {
            this.yr = yr;
        }

    }

    public class CompanyByMonth {

        @SerializedName("qty")
        private Integer qty;

        @SerializedName("monStr")
        private String monStr;

        @SerializedName("mon")
        private Integer mon;

        @SerializedName("yr")
        private Integer yr;

        public Integer getQty() {
            return qty;
        }

        public void setQty(Integer qty) {
            this.qty = qty;
        }

        public String getMonStr() {
            return monStr;
        }

        public void setMonStr(String monStr) {
            this.monStr = monStr;
        }

        public Integer getMon() {
            return mon;
        }

        public void setMon(Integer mon) {
            this.mon = mon;
        }

        public Integer getYr() {
            return yr;
        }

        public void setYr(Integer yr) {
            this.yr = yr;
        }

    }

    public class StoreStock {

        @SerializedName("store")
        private String store;

        @SerializedName("name")
        private String name;

        @SerializedName("qty")
        private int qty;

        @SerializedName("local")
        private int local;

        public String getStore() {
            return store;
        }

        public void setStore(String store) {
            this.store = store;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public Integer getQty() {
            return qty;
        }

        public void setQty(Integer qty) {
            this.qty = qty;
        }

        public Integer getLocal() {
            return local;
        }

        public void setLocal(Integer local) {
            this.local = local;
        }

    }

    public class RelatedProduct {

        @SerializedName("sku")
        private String sku;

        @SerializedName("image")
        private String image;

        @SerializedName("webDesc")
        private String webDesc;

        @SerializedName("retailPrice")
        private Double retailPrice;

        @SerializedName("promoPrice")
        private String promoPrice;

        @SerializedName("ranking")
        private Integer ranking;

        public String getSku() {
            return sku;
        }

        public void setSku(String sku) {
            this.sku = sku;
        }

        public String getImage() {
            return image;
        }

        public void setImage(String image) {
            this.image = image;
        }

        public String getWebDesc() {
            return webDesc;
        }

        public void setWebDesc(String webDesc) {
            this.webDesc = webDesc;
        }

        public Double getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(Double retailPrice) {
            this.retailPrice = retailPrice;
        }

        public String getPromoPrice() {
            return promoPrice;
        }

        public void setPromoPrice(String promoPrice) {
            this.promoPrice = promoPrice;
        }

        public Integer getRanking() {
            return ranking;
        }

        public void setRanking(Integer ranking) {
            this.ranking = ranking;
        }

    }

}








