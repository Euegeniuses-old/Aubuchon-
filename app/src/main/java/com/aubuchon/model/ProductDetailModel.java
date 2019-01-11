
package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

public class ProductDetailModel implements Serializable {

    //  private static final long serialVersionUID = 1L;

    @SerializedName("codes")
    private List<Codes> codes;
    @SerializedName("product")
    private List<Product> product;

    public List<Codes> getCodes() {
        return codes;
    }

    public void setCodes(List<Codes> codes) {
        this.codes = codes;
    }

    public List<Product> getProduct() {
        return product;
    }

    public void setProduct(List<Product> product) {
        this.product = product;
    }

    public static class Product implements Serializable {
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
        private int retailPrice;
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

        public int getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(int retailPrice) {
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
    }

    public static class Codes implements Serializable {
        @SerializedName("altUPC")
        private String altUPC;

        public String getAltUPC() {
            return altUPC;
        }

        public void setAltUPC(String altUPC) {
            this.altUPC = altUPC;
        }
    }

}
