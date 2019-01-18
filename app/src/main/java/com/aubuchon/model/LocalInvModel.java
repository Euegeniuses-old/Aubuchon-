package com.aubuchon.model;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.ArrayList;

public class LocalInvModel implements Serializable {

    @SerializedName("product")
    private ArrayList<Product> product = null;

    @SerializedName("StoreStock")
    private ArrayList<StoreStock> storeStock = null;

    public ArrayList<Product> getProduct() {
        return product;
    }

    public void setProduct(ArrayList<Product> product) {
        this.product = product;
    }

    public ArrayList<StoreStock> getStoreStock() {
        return storeStock;
    }

    public void setStoreStock(ArrayList<StoreStock> storeStock) {
        this.storeStock = storeStock;
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

    public class StoreStock implements Serializable {

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

        public int getQty() {
            return qty;
        }

        public void setQty(int qty) {
            this.qty = qty;
        }

        public int getLocal() {
            return local;
        }

        public void setLocal(int local) {
            this.local = local;
        }

    }

}


