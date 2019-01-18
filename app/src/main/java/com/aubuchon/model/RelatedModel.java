package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class RelatedModel implements Serializable {

    @SerializedName("product")
    private ArrayList<Product> product = null;

    @SerializedName("RelatedProducts")
    private ArrayList<RelatedProduct> relatedProducts = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public ArrayList<RelatedProduct> getRelatedProducts() {
        return relatedProducts;
    }

    public void setRelatedProducts(ArrayList<RelatedProduct> relatedProducts) {
        this.relatedProducts = relatedProducts;
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

    public class RelatedProduct implements Serializable {
        @SerializedName("sku")
        private String sku;

        @SerializedName("image")
        private String image;

        @SerializedName("webDesc")
        private String webDesc;

        @SerializedName("retailPrice")
        private double retailPrice;

        @SerializedName("promoPrice")
        private String promoPrice;

        @SerializedName("ranking")
        private int ranking;

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

        public double getRetailPrice() {
            return retailPrice;
        }

        public void setRetailPrice(double retailPrice) {
            this.retailPrice = retailPrice;
        }

        public String getPromoPrice() {
            return promoPrice;
        }

        public void setPromoPrice(String promoPrice) {
            this.promoPrice = promoPrice;
        }

        public int getRanking() {
            return ranking;
        }

        public void setRanking(int ranking) {
            this.ranking = ranking;
        }

    }

}