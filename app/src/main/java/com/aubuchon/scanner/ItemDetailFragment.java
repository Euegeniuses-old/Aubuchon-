package com.aubuchon.scanner;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v7.widget.AppCompatImageView;
import android.support.v7.widget.AppCompatTextView;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;
import android.widget.ViewFlipper;

import com.aubuchon.HomeFragment;
import com.aubuchon.NavigationActivity;
import com.aubuchon.R;
import com.aubuchon.apis.GetCall;
import com.aubuchon.model.KeyValueModel;
import com.aubuchon.model.LocalInvModel;
import com.aubuchon.model.ProductDetailsModel;
import com.aubuchon.model.ProductModel;
import com.aubuchon.model.RelatedModel;
import com.aubuchon.model.SalesHistoryModel;
import com.aubuchon.model.SalesModel;
import com.aubuchon.utility.Constant;
import com.aubuchon.utility.GlideApp;
import com.aubuchon.utility.Globals;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.google.gson.Gson;
import com.orhanobut.logger.Logger;

import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ItemDetailFragment extends Fragment implements OnCheckedChangeListener, OnItemClickListener {

    @BindView(R.id.radio_group_1)
    RadioGroup rg1;
    @BindView(R.id.radio_group_2)
    RadioGroup rg2;
    @BindView(R.id.view_flipper)
    ViewFlipper view_flipper;
    @BindView(R.id.rv_local_inventory)
    RecyclerView rv_local_inventory;
    @BindView(R.id.rv_inquiry)
    RecyclerView rv_inquiry;
    @BindView(R.id.rv_sales_history)
    RecyclerView rv_sales_history;
    @BindView(R.id.rv_order_info)
    RecyclerView rv_order_info;
    @BindView(R.id.rv_related_products)
    RecyclerView rv_related_products;
    @BindView(R.id.tv_no_data)
    AppCompatTextView tvNoData;
    @BindView(R.id.iv_photo)
    AppCompatImageView iv_photo;
    @BindView(R.id.fab_prev_item)
    FloatingActionButton fab_prev_item;

    ProductDetailsModel productDetailModel;
   /* ArrayList<ProductDetailsModel.Product> productArrayList;
    ArrayList<ProductDetailsModel.StoreStock> stockArrayList;
    ArrayList<ProductDetailsModel.StoresByMonth> storesByMonthsList;
    ArrayList<ProductDetailsModel.CompanyByMonth> companyByMonthsList;
    ArrayList<ProductDetailsModel.RelatedProduct> relatedProducts;*/

    /*New Models & ArrayLists*/
    ProductModel productModel;
    ArrayList<ProductModel.Product> productsList;

    LocalInvModel localInvModel;
    ArrayList<LocalInvModel.StoreStock> stocksList;

    SalesModel salesModel;
    ArrayList<SalesModel.StoresByMonth> storesByMonthArrayList;
    ArrayList<SalesModel.CompanyByMonth> companyByMonthArrayList;

    RelatedModel relatedModel;
    ArrayList<RelatedModel.RelatedProduct> relatedProductArrayList;


    String data;
    NavigationActivity mContext;
    Globals globals;
    boolean isFromRelated = false;

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        try {
            mContext = (NavigationActivity) context;
        } catch (ClassCastException e) {
            e.printStackTrace();
        }
    }

    public static ItemDetailFragment newInstance(String barcode) {
        ItemDetailFragment fragment = new ItemDetailFragment();
        Bundle bundle = new Bundle();
        bundle.putString(Constant.AU_data, barcode);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        globals = (Globals) getActivity().getApplicationContext();
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.activity_item_detail, container, false);
        ButterKnife.bind(this, view);
        rg1.clearCheck(); // this is so we can start fresh, with no selection on both RadioGroups
        rg2.clearCheck();
        rg1.setOnCheckedChangeListener(this);
        rg2.setOnCheckedChangeListener(this);
        rg1.check(R.id.btn_inquiry);

       /* productArrayList = new ArrayList<>();
        stockArrayList = new ArrayList<>();
        storesByMonthsList = new ArrayList<>();
        companyByMonthsList = new ArrayList<>();
        relatedProducts = new ArrayList<>();*/

        /*New*/
        productsList = new ArrayList<>();
        stocksList = new ArrayList<>();
        storesByMonthArrayList = new ArrayList<>();
        companyByMonthArrayList = new ArrayList<>();
        relatedProductArrayList = new ArrayList<>();


        data = getArguments().getString(Constant.AU_data);

        mContext.toolbar_title.setText(String.format(getString(R.string.text_sku), data));
        mContext.ll_desc.setVisibility(View.GONE);

        /*Handle click of "More" TextView of Toolbar*/
        mContext.navigationActivity.tv_more.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                rg1.check(R.id.btn_inquiry);
            }
        });

        doRequestForGetProductDetail();

        return view;
    }

    @Override
    public void onCheckedChanged(RadioGroup radioGroup, int checkedId) {
        switch (radioGroup.getId()) {
            case R.id.radio_group_1:
                if (checkedId != -1) {
                    rg2.setOnCheckedChangeListener(null); // remove the listener before clearing so we don't throw that stackoverflow exception(like Vladimir Volodin pointed out)
                    rg2.clearCheck(); // clear the second RadioGroup!
                    rg2.setOnCheckedChangeListener(this); //reset the listener

                    switch (checkedId) {
                        case R.id.btn_inquiry:
                            view_flipper.setDisplayedChild(0);
                            break;
                        case R.id.btn_sales_history:
                            view_flipper.setDisplayedChild(4);
                            break;
                        case R.id.btn_order_info:
                            view_flipper.setDisplayedChild(3);
                            break;
                        case R.id.btn_related_items:
                            view_flipper.setDisplayedChild(5);
                            break;
                    }
                }
                break;
            case R.id.radio_group_2:
                if (checkedId != -1) {
                    rg1.setOnCheckedChangeListener(null);
                    rg1.clearCheck();
                    rg1.setOnCheckedChangeListener(this);

                    switch (checkedId) {

                        case R.id.btn_local:
                            view_flipper.setDisplayedChild(2);
                            break;
                        case R.id.btn_photo:
                            view_flipper.setDisplayedChild(1);
                            break;
                        case R.id.btn_tbd_one:
                            view_flipper.setDisplayedChild(6);
                            break;
                        case R.id.btn_tbd:
                            view_flipper.setDisplayedChild(7);
                            break;
                    }
                }
                break;
        }
    }

    private void setCurrentPrevious() {
        String current = globals.getCurrentProductCode();
        String old = globals.getPreviousProductCode();

        if (current == null && old == null) {
            globals.setPreviousProductCode(data);
            globals.setCurrentProductCode(data);
        } else if (current != null && !current.equals(data)) {
            if (current.equalsIgnoreCase(data)) {
                globals.setPreviousProductCode(data);
                globals.setCurrentProductCode(data);
            } else {
                globals.setPreviousProductCode(current);
                globals.setCurrentProductCode(data);
            }
        } else if ((current != null && old != null && !current.isEmpty() && !old.isEmpty())) {
            if (current.equalsIgnoreCase(data)) {
                globals.setPreviousProductCode(data);
                globals.setCurrentProductCode(data);
            } else {
                globals.setPreviousProductCode(current);
                globals.setCurrentProductCode(data);
            }
        } else {
            if (current != null && current.equalsIgnoreCase(data)) {
                globals.setPreviousProductCode(data);
                globals.setCurrentProductCode(data);
            } else {
                globals.setPreviousProductCode(current);
                globals.setCurrentProductCode(data);
            }
        }
    }

    public void doRequestForGetProductDetail() {
        String url = getString(R.string.product_store_url) + "branchcode=156&data=" + data;
        Logger.v("Product Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @SuppressLint("RestrictedApi")
            @Override
            public void onSucceedToGetCall(JSONObject response) {

               /* productDetailModel = new ProductDetailsModel();
                productDetailModel = new Gson().fromJson(response.toString(), ProductDetailsModel.class);

                if (productDetailModel.getProduct().size() > 0) {

                    if (!globals.isFromMenu) {
                        setCurrentPrevious();
                    }

                    if (isFromRelated) {
                        fab_prev_item.setVisibility(View.VISIBLE);
                    } else {
                        fab_prev_item.setVisibility(View.GONE);
                    }

                    rg1.check(R.id.btn_inquiry);

                    setInquiryData();
                    setLocalInvData();
                    setSalesHistoryData();
                    setOrderInfoData();
                    setRelatedData();
                    setPhoto();
                } else {

                    Globals.showToast(getActivity(), getString(R.string.msg_enter_valid_barcode));
                    globals.setPreviousProductCode(globals.getCurrentProductCode());
                    mContext.toolbar_title.setText("");
                    mContext.ll_desc.setVisibility(View.GONE);
                    mContext.addFragmentOnTop(HomeFragment.newInstance());
                }*/

                productModel = new ProductModel();
                productModel = new Gson().fromJson(response.toString(), ProductModel.class);

                if (productModel.getProduct().size() > 0) {

                    if (!globals.isFromMenu) {
                        setCurrentPrevious();
                    }

                    if (isFromRelated) {
                        fab_prev_item.setVisibility(View.VISIBLE);
                    } else {
                        fab_prev_item.setVisibility(View.GONE);
                    }

                    rg1.check(R.id.btn_inquiry);
                    setInquiryData();
                    setOrderInfoData();
                    setPhoto();
                    doRequestForLocalInventoryData();
                    doRequestForSalesHistoryData();
                    doRequestForRelatedData();

                } else {
                    Globals.showToast(getActivity(), getString(R.string.msg_enter_valid_barcode));
                    globals.setPreviousProductCode(globals.getCurrentProductCode());
                    mContext.toolbar_title.setText("");
                    mContext.ll_desc.setVisibility(View.GONE);
                    mContext.addFragmentOnTop(HomeFragment.newInstance());
                }

            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(getActivity(), getString(R.string.msg_not_found));
            }
        }, true).doRequest();

    }

    private void doRequestForLocalInventoryData() {
        String url = getString(R.string.inventory_url) + "branchcode=156&data=" + data;
        Logger.v("Inventory Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {
                localInvModel = new LocalInvModel();
                localInvModel = new Gson().fromJson(response.toString(), LocalInvModel.class);
                if (localInvModel.getStoreStock().size() > 0) {
                    setLocalInvData();
                }
            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(getActivity(), getString(R.string.msg_not_found));
            }
        }, true).doRequest();
    }

    private void doRequestForSalesHistoryData() {
        String url = getString(R.string.sales_url) + "branchcode=156&data=" + data;
        Logger.v("Sales Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {
                salesModel = new SalesModel();
                salesModel = new Gson().fromJson(response.toString(), SalesModel.class);
                if (salesModel.getStoresByMonth().size() > 0 && salesModel.getCompanyByMonth().size() > 0) {
                    setSalesHistoryData();
                }
            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(getActivity(), getString(R.string.msg_not_found));
            }
        }, true).doRequest();
    }

    private void doRequestForRelatedData() {
        String url = getString(R.string.related_url) + "branchcode=156&data=" + data;
        Logger.v("Related Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {

                relatedModel = new RelatedModel();
                relatedModel = new Gson().fromJson(response.toString(), RelatedModel.class);
                if (relatedModel.getRelatedProducts().size() > 0) {
                    setRelatedData();
                }
            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(getActivity(), getString(R.string.msg_not_found));
            }
        }, true).doRequest();
    }

    /*Load Photo from ProductDetails*/
    private void setPhoto() {
        if (productsList != null && productsList.get(0).getImageURL() != null && !productsList.get(0).getImageURL().isEmpty()) {
            GlideApp.with(mContext)
                    .load(productsList.get(0).getImageURL())
                    .placeholder(R.drawable.camera)
                    .dontAnimate()
                    .diskCacheStrategy(DiskCacheStrategy.NONE)
                    .dontTransform()
                    .into(iv_photo);
        } else {
            GlideApp.with(mContext)
                    .load(R.drawable.camera)
                    .placeholder(R.drawable.camera)
                    .dontAnimate()
                    .diskCacheStrategy(DiskCacheStrategy.NONE)
                    .dontTransform()
                    .into(iv_photo);
        }
    }

    /*Inquiry Data*/
    public void setInquiryData() {
        ArrayList<KeyValueModel> inquiryData = new ArrayList<>();
        if (rv_inquiry.getAdapter() != null) {
            rv_inquiry.getAdapter().notifyDataSetChanged();
        }
       /* productArrayList = new ArrayList<>();
        productArrayList = productDetailModel.getProduct();*/

        productsList = new ArrayList<>();
        productsList = productModel.getProduct();

        inquiryData.add(new KeyValueModel("Item Number", productsList.get(0).getSku()));

        /*if (isFromRelated) {
            mContext.navigationActivity.toolbar_title.setText(String.format(getString(R.string.text_sku), productArrayList.get(0).getSku()));
        }*/
        mContext.navigationActivity.toolbar_title.setText(String.format(getString(R.string.text_sku), data));

        /*Set intent to Open Detail in Browser*/
        mContext.navigationActivity.toolbar_title.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Logger.v("Detail Url: " + Uri.parse(productsList.get(0).getUrlKey()).toString());
                Intent browserIntent = new Intent(Intent.ACTION_VIEW,Uri.parse(productsList.get(0).getUrlKey()));
                Intent browserChooserIntent = Intent.createChooser(browserIntent , "Choose browser to open");
                startActivity(browserChooserIntent);
            }
        });


        if (!productsList.get(0).getWebDesc().isEmpty()) {
            inquiryData.add(new KeyValueModel("Desc", productsList.get(0).getPosDesc()));
            mContext.tv_desc.setText(productsList.get(0).getPosDesc());
            mContext.ll_desc.setVisibility(View.VISIBLE);
        } else {
            mContext.tv_desc.setText("");
            mContext.ll_desc.setVisibility(View.GONE);
        }
        inquiryData.add(new KeyValueModel("Price", String.valueOf(productsList.get(0).getRetailPrice())));
        inquiryData.add(new KeyValueModel("Promo", productsList.get(0).getPromoPrice()));
        inquiryData.add(new KeyValueModel("Available", String.valueOf(productsList.get(0).getAvailable())));
        inquiryData.add(new KeyValueModel("On Hand", String.valueOf(productsList.get(0).getOnHandAmt())));
        inquiryData.add(new KeyValueModel("Section", productsList.get(0).getSection()));
        inquiryData.add(new KeyValueModel("Speed #", productsList.get(0).getSpeedNo()));

        InquiryListAdapter inquiryListAdapter = new InquiryListAdapter(mContext);
        inquiryListAdapter.doRefresh(inquiryData);
        if (rv_inquiry.getAdapter() == null) {
            rv_inquiry.setHasFixedSize(false);
            rv_inquiry.setLayoutManager(new LinearLayoutManager(mContext));
        }
        rv_inquiry.setAdapter(inquiryListAdapter);
    }

    /*Order Info Data*/
    public void setOrderInfoData() {
        ArrayList<KeyValueModel> inquiryData = new ArrayList<>();
        inquiryData.clear();
        inquiryData.add(new KeyValueModel("Last Sold", productsList.get(0).getLastSoldDate()));
        inquiryData.add(new KeyValueModel("QTY on Order", String.valueOf(productsList.get(0).getOnOrderAmt())));
        inquiryData.add(new KeyValueModel("PO Number", productsList.get(0).getOnOrderPO()));
        inquiryData.add(new KeyValueModel("Primary Vendor", productsList.get(0).getSupplierName()));
        inquiryData.add(new KeyValueModel("Vendor#", productsList.get(0).getSupplier()));
        inquiryData.add(new KeyValueModel("Delivery Date", productsList.get(0).getLastDelDate()));
        inquiryData.add(new KeyValueModel("Min", String.valueOf(productsList.get(0).getMinStk())));
        inquiryData.add(new KeyValueModel("Max", String.valueOf(productsList.get(0).getMaxStk())));
        inquiryData.add(new KeyValueModel("Reorder", String.valueOf(productsList.get(0).getReOrdPoint())));

        InquiryListAdapter inquiryListAdapter = new InquiryListAdapter(getActivity());
        inquiryListAdapter.doRefresh(inquiryData);
        if (rv_order_info.getAdapter() == null) {
            rv_order_info.setHasFixedSize(false);
            rv_order_info.setLayoutManager(new LinearLayoutManager(getActivity()));
        }
        rv_order_info.setAdapter(inquiryListAdapter);
    }

    /*Local Inv Data*/
    public void setLocalInvData() {
        int localCount = 0;
        stocksList = new ArrayList<>();
        ArrayList<LocalInvModel.StoreStock> storeStockArrayList = new ArrayList<>();
        if (localInvModel.getStoreStock() != null && localInvModel.getStoreStock().size() > 0) {
            stocksList = localInvModel.getStoreStock();

            /*Sorting of Data in Alphabetic Order*/
            Collections.sort(stocksList, new Comparator<LocalInvModel.StoreStock>() {
                @Override
                public int compare(LocalInvModel.StoreStock o1, LocalInvModel.StoreStock o2) {
                    return o1.getName().toLowerCase().compareTo(o2.getName().toLowerCase());
                }
            });

            /*Separate Data where Local = 1*/
            for (int i = 0; i < stocksList.size(); i++) {
                if (stocksList.get(i).getLocal() == 1) {
                    storeStockArrayList.add(stocksList.get(i));
                    localCount++;
                }
            }

            /*Remove Data where Local = 1*/
            for (int i = 0; i < stocksList.size(); i++) {
                if (stocksList.get(i).getLocal() == 1) {
                    stocksList.remove(i);
                }
            }

            /*Merge Old Array into Main Array*/
            storeStockArrayList.addAll(stocksList);
        }

        LocalInvListAdapter localInvListAdapter = new LocalInvListAdapter(getActivity(), localCount);
        localInvListAdapter.doRefresh(storeStockArrayList);
        if (rv_local_inventory.getAdapter() == null) {
            rv_local_inventory.setHasFixedSize(false);
            rv_local_inventory.setLayoutManager(new LinearLayoutManager(getActivity()));
        }
        rv_local_inventory.setAdapter(localInvListAdapter);
    }

    /*Sales History Data*/
    public void setSalesHistoryData() {
        storesByMonthArrayList = new ArrayList<>();
        companyByMonthArrayList = new ArrayList<>();
        storesByMonthArrayList = salesModel.getStoresByMonth();
        companyByMonthArrayList = salesModel.getCompanyByMonth();
        ArrayList<SalesHistoryModel> salesHistoryModel = new ArrayList<>();

        if (storesByMonthArrayList.size() == companyByMonthArrayList.size()) {
            for (int i = 0; i < storesByMonthArrayList.size(); i++) {
                salesHistoryModel.add(new SalesHistoryModel(Globals.getMonthForInt(storesByMonthArrayList.get(i).getMon()) + " " + storesByMonthArrayList.get(i).getYr(),
                        storesByMonthArrayList.get(i).getQty(),
                        companyByMonthArrayList.get(i).getQty(), storesByMonthArrayList.get(i).getYr()));
            }
        }

        /*Collections.sort(salesHistoryModel, new Comparator<SalesHistoryModel>() {
            @Override
            public int compare(SalesHistoryModel o1, SalesHistoryModel o2) {
                return o1.getMonth().toLowerCase().compareTo(o2.getMonth().toLowerCase());
            }
        });*/

        Collections.sort(salesHistoryModel, new Comparator<SalesHistoryModel>() {
            @Override
            public int compare(SalesHistoryModel o1, SalesHistoryModel o2) {
                /*Working*/
                return o2.getYear() - o1.getYear();
            }
        });


        SalesHistoryListAdapter storeListAdapter = new SalesHistoryListAdapter(getActivity());
        storeListAdapter.doRefresh(salesHistoryModel);
        if (rv_sales_history.getAdapter() == null) {
            rv_sales_history.setHasFixedSize(false);
            rv_sales_history.setLayoutManager(new LinearLayoutManager(getActivity()));
        }
        rv_sales_history.setAdapter(storeListAdapter);
    }

    /*Related Data*/
    public void setRelatedData() {
        relatedProductArrayList = new ArrayList<>();
        relatedProductArrayList = relatedModel.getRelatedProducts();

        RelatedProductsAdapter relatedProductsAdapter = new RelatedProductsAdapter(getActivity(), this);
        relatedProductsAdapter.doRefresh(relatedProductArrayList);
        if (rv_related_products.getAdapter() == null) {
            rv_related_products.setHasFixedSize(false);
            rv_related_products.setLayoutManager(new LinearLayoutManager(getActivity()));
        }
        rv_related_products.setAdapter(relatedProductsAdapter);

    }


    /*Handle Click of Floating Back Button*/
    @SuppressLint("RestrictedApi")
    @OnClick(R.id.fab_prev_item)
    public void fabClick() {
        data = globals.getPreviousProductCode();
        isFromRelated = false;
        globals.isFromMenu = false;
        doRequestForGetProductDetail();
    }

    /*Handle Click event of Related Items*/
    @Override
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
        data = relatedProductArrayList.get(i).getSku();
        isFromRelated = true;
        doRequestForGetProductDetail();
    }

}
