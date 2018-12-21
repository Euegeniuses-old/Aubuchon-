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

    public static class Product implements Serializable{
        @SerializedName("SupplierName")
        private String SupplierName;
        @SerializedName("Supplier")
        private String Supplier;
        @SerializedName("DcStock")
        private int DcStock;
        @SerializedName("OneYrSales")
        private int OneYrSales;
        @SerializedName("OneYearSales")
        private int OneYearSales;
        @SerializedName("imageURL")
        private String imageURL;
        @SerializedName("retailPrice")
        private double retailPrice;
        @SerializedName("prodstatus")
        private String prodstatus;
        @SerializedName("DiscDate")
        private String DiscDate;
        @SerializedName("purchunits")
        private String purchunits;
        @SerializedName("ORDNUM")
        private String ORDNUM;
        @SerializedName("PlangramDesc")
        private String PlangramDesc;
        @SerializedName("Planogram")
        private String Planogram;
        @SerializedName("SubClassName")
        private String SubClassName;
        @SerializedName("ClassName")
        private String ClassName;
        @SerializedName("DepartmentName")
        private String DepartmentName;
        @SerializedName("buyer")
        private String buyer;
        @SerializedName("proddesc")
        private String proddesc;
        @SerializedName("create_a_sign_desc")
        private String create_a_sign_desc;
        @SerializedName("prodcode")
        private String prodcode;
        @SerializedName("branchcode")
        private String branchcode;
        @SerializedName("prodint")
        private int prodint;

        public String getSupplierName() {
            return SupplierName;
        }

        public void setSupplierName(String supplierName) {
            SupplierName = supplierName;
        }

        public String getSupplier() {
            return Supplier;
        }

        public void setSupplier(String supplier) {
            Supplier = supplier;
        }

        public int getDcStock() {
            return DcStock;
        }

        public void setDcStock(int dcStock) {
            DcStock = dcStock;
        }

        public int getOneYrSales() {
            return OneYrSales;
        }

        public void setOneYrSales(int oneYrSales) {
            OneYrSales = oneYrSales;
        }

        public int getOneYearSales() {
            return OneYearSales;
        }

        public void setOneYearSales(int oneYearSales) {
            OneYearSales = oneYearSales;
        }

        public String getImageURL() {
            return imageURL;
        }

        public void setImageURL(String imageURL) {
            this.imageURL = imageURL;
        }

        public double getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(double retailPrice) {
            this.retailPrice = retailPrice;
        }

        public String getProdstatus() {
            return prodstatus;
        }

        public void setProdstatus(String prodstatus) {
            this.prodstatus = prodstatus;
        }

        public String getDiscDate() {
            return DiscDate;
        }

        public void setDiscDate(String discDate) {
            DiscDate = discDate;
        }

        public String getPurchunits() {
            return purchunits;
        }

        public void setPurchunits(String purchunits) {
            this.purchunits = purchunits;
        }

        public String getORDNUM() {
            return ORDNUM;
        }

        public void setORDNUM(String ORDNUM) {
            this.ORDNUM = ORDNUM;
        }

        public String getPlangramDesc() {
            return PlangramDesc;
        }

        public void setPlangramDesc(String plangramDesc) {
            PlangramDesc = plangramDesc;
        }

        public String getPlanogram() {
            return Planogram;
        }

        public void setPlanogram(String planogram) {
            Planogram = planogram;
        }

        public String getSubClassName() {
            return SubClassName;
        }

        public void setSubClassName(String subClassName) {
            SubClassName = subClassName;
        }

        public String getClassName() {
            return ClassName;
        }

        public void setClassName(String className) {
            ClassName = className;
        }

        public String getDepartmentName() {
            return DepartmentName;
        }

        public void setDepartmentName(String departmentName) {
            DepartmentName = departmentName;
        }

        public String getBuyer() {
            return buyer;
        }

        public void setBuyer(String buyer) {
            this.buyer = buyer;
        }

        public String getProddesc() {
            return proddesc;
        }

        public void setProddesc(String proddesc) {
            this.proddesc = proddesc;
        }

        public String getCreate_a_sign_desc() {
            return create_a_sign_desc;
        }

        public void setCreate_a_sign_desc(String create_a_sign_desc) {
            this.create_a_sign_desc = create_a_sign_desc;
        }

        public String getProdcode() {
            return prodcode;
        }

        public void setProdcode(String prodcode) {
            this.prodcode = prodcode;
        }

        public String getBranchcode() {
            return branchcode;
        }

        public void setBranchcode(String branchcode) {
            this.branchcode = branchcode;
        }

        public int getProdint() {
            return prodint;
        }

        public void setProdint(int prodint) {
            this.prodint = prodint;
        }
    }
    public static class Codes implements Serializable{
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