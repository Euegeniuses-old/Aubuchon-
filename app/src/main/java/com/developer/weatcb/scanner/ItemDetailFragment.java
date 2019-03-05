package com.developer.weatcb.scanner;

import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.design.widget.FloatingActionButton;
import android.support.v4.app.Fragment;
import android.support.v4.content.ContextCompat;
import android.support.v7.widget.AppCompatImageView;
import android.support.v7.widget.AppCompatRadioButton;
import android.support.v7.widget.AppCompatTextView;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.LinearLayout;
import android.widget.RadioGroup;
import android.widget.RadioGroup.OnCheckedChangeListener;
import android.widget.ViewFlipper;

import com.developer.weatcb.HomeFragment;
import com.developer.weatcb.NavigationActivity;
import com.developer.R;
import com.developer.weatcb.apis.GetCall;
import com.developer.weatcb.model.KeyValueModel;
import com.developer.weatcb.model.LocalInvModel;
import com.developer.weatcb.model.ProductModel;
import com.developer.weatcb.model.RelatedModel;
import com.developer.weatcb.model.SalesHistoryModel;
import com.developer.weatcb.model.SalesModel;
import com.developer.weatcb.utility.Constant;
import com.developer.weatcb.utility.Globals;
import com.google.gson.Gson;
import com.orhanobut.logger.Logger;
import com.squareup.picasso.Picasso;

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
    @BindView(R.id.ll_local_inv)
    LinearLayout ll_local_inv;
    @BindView(R.id.rv_local_inventory)
    RecyclerView rv_local_inventory;
    @BindView(R.id.tv_local_inv_not_found)
    AppCompatTextView tv_local_inv_not_found;

    @BindView(R.id.rv_inquiry)
    RecyclerView rv_inquiry;
    @BindView(R.id.tv_no_data)
    AppCompatTextView tv_no_data;

    @BindView(R.id.rv_sales_history)
    RecyclerView rv_sales_history;
    @BindView(R.id.ll_sales_history_header)
    LinearLayout ll_sales_history_header;
    @BindView(R.id.tv_branch_code)
    AppCompatTextView tv_branch_code;
    @BindView(R.id.tv_sales_history_not_found)
    AppCompatTextView tv_sales_history_not_found;

    @BindView(R.id.rv_order_info)
    RecyclerView rv_order_info;
    @BindView(R.id.tv_order_info_not_found)
    AppCompatTextView tv_order_info_not_found;

    @BindView(R.id.rv_related_products)
    RecyclerView rv_related_products;
    @BindView(R.id.tv_related_not_found)
    AppCompatTextView tv_related_not_found;

    @BindView(R.id.btn_photo)
    AppCompatRadioButton btn_photo;
    @BindView(R.id.iv_photo)
    AppCompatImageView iv_photo;
    @BindView(R.id.tv_product_link)
    AppCompatTextView tv_product_link;

    @BindView(R.id.fab_prev_item)
    FloatingActionButton fab_prev_item;

    ProductModel productModel;
    ArrayList<ProductModel.Product> productsList;

    LocalInvModel localInvModel;
    ArrayList<LocalInvModel.StoreStock> stocksList;

    SalesModel salesModel;
    ArrayList<SalesModel.SalesByMonth> salesByMonths;

    RelatedModel relatedModel;
    ArrayList<RelatedModel.RelatedProduct> relatedProductArrayList;

    NavigationActivity mContext;
    Globals globals;
    String branchcode, data;
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
        globals = (Globals) mContext.getApplicationContext();
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.activity_item_detail, container, false);
        ButterKnife.bind(this, view);

        Globals.hideKeyboard(mContext);

        rg1.clearCheck(); // this is so we can start fresh, with no selection on both RadioGroups
        rg2.clearCheck();
        rg1.setOnCheckedChangeListener(this);
        rg2.setOnCheckedChangeListener(this);
        rg1.check(R.id.btn_inquiry);

        productsList = new ArrayList<>();
        stocksList = new ArrayList<>();
        salesByMonths = new ArrayList<>();
        relatedProductArrayList = new ArrayList<>();

        branchcode = globals.getBranchCode();

        if (getArguments() != null) {
            data = getArguments().getString(Constant.AU_data);
        }

        mContext.tv_desc.setVisibility(View.GONE);
        mContext.toolbar_title.setVisibility(View.GONE);

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

    private void doRequestForGetProductDetail() {
        String url = getString(R.string.product_store_url) + "branchcode=" + branchcode + "&data=" + data;
        Logger.v("Product Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @SuppressLint("RestrictedApi")
            @Override
            public void onSucceedToGetCall(JSONObject response) {

                productModel = new ProductModel();
                productModel = new Gson().fromJson(response.toString(), ProductModel.class);

                if (productModel.getProduct().size() > 0) {

                    tv_no_data.setVisibility(View.GONE);

                    if (!globals.isFromMenu) {
                        setCurrentPrevious();
                    }

                    if (isFromRelated) {
                        fab_prev_item.setVisibility(View.VISIBLE);
                    } else {
                        fab_prev_item.setVisibility(View.GONE);
                    }

                    rg1.check(R.id.btn_inquiry);
                    rv_inquiry.setVisibility(View.VISIBLE);
                    setInquiryData();
                    setOrderInfoData();

                    /*Set Button Grey, If ImageUrl is not available*/
                    if (productModel.getProduct().get(0).getImageURL() != null && productModel.getProduct().get(0).getImageURL().length() > 0) {
                        btn_photo.setEnabled(true);
                        btn_photo.setBackground(ContextCompat.getDrawable(mContext, R.drawable.button_selector));
                        setPhoto();
                    } else {
                        btn_photo.setEnabled(false);
                        btn_photo.setBackground(ContextCompat.getDrawable(mContext, R.drawable.tab_disable));
                    }

                    doRequestForSalesHistoryData();
                    doRequestForLocalInventoryData();
                    doRequestForRelatedData();

                } else {
                    Globals.showToast(getActivity(), getString(R.string.msg_enter_valid_barcode));
                    globals.setPreviousProductCode(globals.getCurrentProductCode());
                    mContext.toolbar_title.setText("");
                    mContext.toolbar_title.setVisibility(View.GONE);
                    mContext.tv_desc.setVisibility(View.GONE);
                    mContext.addFragmentOnTop(HomeFragment.newInstance());
                }

            }

            @Override
            public void onFailedToGetCall() {

                if (isFromRelated) {
                    doRequestForGetProductDetail();
                }

                Globals.showToast(getActivity(), getString(R.string.error_msg_something_went_wrong));
                productsList = new ArrayList<>();
                rv_inquiry.setVisibility(View.GONE);
                rv_order_info.setVisibility(View.GONE);
                tv_no_data.setText(mContext.getString(R.string.error_msg_something_went_wrong));
                tv_no_data.setVisibility(View.VISIBLE);
                tv_order_info_not_found.setText(mContext.getString(R.string.error_msg_something_went_wrong));
                tv_order_info_not_found.setVisibility(View.VISIBLE);

            }
        }, true).doRequest();

    }

    private void doRequestForLocalInventoryData() {
        String url = getString(R.string.inventory_url) + "branchcode=" + branchcode + "&data=" + data;
        Logger.v("Inventory Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {
                localInvModel = new LocalInvModel();
                localInvModel = new Gson().fromJson(response.toString(), LocalInvModel.class);
                if (localInvModel.getStoreStock().size() > 0) {
                    setLocalInvData();
                } else {
                    ll_local_inv.setVisibility(View.GONE);
                    tv_local_inv_not_found.setText(mContext.getString(R.string.msg_details_not_found));
                    tv_local_inv_not_found.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailedToGetCall() {
                ll_local_inv.setVisibility(View.GONE);
                tv_local_inv_not_found.setText(mContext.getString(R.string.error_msg_something_went_wrong));
                tv_local_inv_not_found.setVisibility(View.VISIBLE);
            }
        }, true).doRequest();
    }

    private void doRequestForSalesHistoryData() {
        String url = getString(R.string.sales_url) + "branchcode=" + branchcode + "&data=" + data;
        Logger.v("Sales History Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {
                salesModel = new SalesModel();
                salesModel = new Gson().fromJson(response.toString(), SalesModel.class);
                if (salesModel.getSalesByMonth().size() > 0) {
                    setSalesHistoryData();
                } else {
                    ll_sales_history_header.setVisibility(View.GONE);
                    rv_sales_history.setVisibility(View.GONE);
                    tv_sales_history_not_found.setText(mContext.getString(R.string.msg_details_not_found));
                    tv_sales_history_not_found.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailedToGetCall() {
                ll_sales_history_header.setVisibility(View.GONE);
                rv_sales_history.setVisibility(View.GONE);
                tv_sales_history_not_found.setText(mContext.getString(R.string.error_msg_something_went_wrong));
                tv_sales_history_not_found.setVisibility(View.VISIBLE);

            }
        }, true).doRequest();
    }

    private void doRequestForRelatedData() {
        String url = getString(R.string.related_url) + "branchcode=" + branchcode + "&data=" + data;
        Logger.v("Related Url: " + url);
        new GetCall(getActivity(), url, new JSONObject(), new GetCall.OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {

                relatedModel = new RelatedModel();
                relatedModel = new Gson().fromJson(response.toString(), RelatedModel.class);
                if (relatedModel.getRelatedProducts().size() > 0) {
                    setRelatedData();
                } else {
                    rv_related_products.setVisibility(View.GONE);
                    tv_related_not_found.setText(mContext.getString(R.string.msg_details_not_found));
                    tv_related_not_found.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onFailedToGetCall() {
                rv_related_products.setVisibility(View.GONE);
                tv_related_not_found.setText(mContext.getString(R.string.error_msg_something_went_wrong));
                tv_related_not_found.setVisibility(View.VISIBLE);
            }
        }, true).doRequest();
    }

    /**
     * Load Photo from ProductDetails
     */
    private void setPhoto() {

        /*Product Detail Link*/
        tv_product_link.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Logger.v("Detail Url: " + Uri.parse(productsList.get(0).getUrlKey()).toString());
                if (productsList.get(0).getUrlKey().length() > 0) {
                    Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(productsList.get(0).getUrlKey()));
                    Intent browserChooserIntent = Intent.createChooser(browserIntent, getString(R.string.msg_choose_browser));
                    startActivity(browserChooserIntent);
                } else {
                    Globals.showToast(mContext, getString(R.string.msg_link_not_available));
                }
            }
        });


        if (productsList != null && productsList.get(0).getImageURL() != null && !productsList.get(0).getImageURL().isEmpty()) {
            Picasso.with(Globals.getContext())
                    .load(productsList.get(0).getImageURL())
                    .placeholder(R.drawable.camera)
                    .noFade()
                    .into(iv_photo);
        } else {
            Picasso.with(Globals.getContext())
                    .load(R.drawable.camera)
                    .placeholder(R.drawable.camera)
                    .noFade()
                    .into(iv_photo);
        }
    }

    /**
     * Inquiry Data
     */
    private void setInquiryData() {
        ArrayList<KeyValueModel> inquiryData = new ArrayList<>();
        productsList = new ArrayList<>();
        productsList = productModel.getProduct();

        inquiryData.add(new KeyValueModel(Constant.AU_item_number, productsList.get(0).getSku()));
        mContext.navigationActivity.toolbar_title.setText(String.format(getString(R.string.text_sku), productsList.get(0).getSku()));
        mContext.navigationActivity.toolbar_title.setVisibility(View.VISIBLE);

        /*Display UPC from "Table 1" ArrayList*/
        if (productModel.getTable1().size() > 0) {
            for (int i = 0; i < productModel.getTable1().size(); i++) {
                if (productModel.getTable1().get(i).getPrimary()) {
                    inquiryData.add(new KeyValueModel(Constant.AU_upc, productModel.getTable1().get(i).getAltUPC()));
                }
            }
        }

        if (!productsList.get(0).getWebDesc().isEmpty()) {
            inquiryData.add(new KeyValueModel(Constant.AU_desc, productsList.get(0).getPosDesc()));
            mContext.tv_desc.setText(productsList.get(0).getPosDesc());
            mContext.tv_desc.setVisibility(View.VISIBLE);
        } else {
            mContext.tv_desc.setText("");
            mContext.tv_desc.setVisibility(View.GONE);
        }

        inquiryData.add(new KeyValueModel(Constant.AU_section, productsList.get(0).getSection()));
        inquiryData.add(new KeyValueModel(Constant.AU_speed, productsList.get(0).getSpeedNo()));
        inquiryData.add(new KeyValueModel(Constant.AU_available, String.valueOf(productsList.get(0).getAvailable())));
        inquiryData.add(new KeyValueModel(Constant.AU_on_hand, String.valueOf(productsList.get(0).getOnHandAmt())));
        inquiryData.add(new KeyValueModel(Constant.AU_price, String.valueOf(productsList.get(0).getRetailPrice())));
        inquiryData.add(new KeyValueModel(Constant.AU_promo, productsList.get(0).getPromoPrice()));
        inquiryData.add(new KeyValueModel(Constant.AU_status, productsList.get(0).getProdStatus()));

        /*Pass count of above items in order to add Rating layout in Adapter*/
        int count = inquiryData.size();

        inquiryData.add(new KeyValueModel(Constant.AU_rating, String.valueOf(productsList.get(0).getRating())));
        inquiryData.add(new KeyValueModel(Constant.AU_web_desc, String.valueOf(productsList.get(0).getWebDesc())));

        InquiryListAdapter inquiryListAdapter = new InquiryListAdapter(mContext, count);
        inquiryListAdapter.doRefresh(inquiryData);

        rv_inquiry.setHasFixedSize(false);
        rv_inquiry.setLayoutManager(new LinearLayoutManager(mContext));
        rv_inquiry.setAdapter(inquiryListAdapter);
    }

    /**
     * Order Info Data
     */
    private void setOrderInfoData() {
        ArrayList<KeyValueModel> orderInfoData = new ArrayList<>();
        orderInfoData.clear();

        orderInfoData.add(new KeyValueModel(Constant.AU_last_sold,
                !productsList.get(0).getLastSoldDate().equals("") ?
                        Globals.convertDateFormat(productsList.get(0).getLastSoldDate()) : ""));

        orderInfoData.add(new KeyValueModel(Constant.AU_qty_on_order, String.valueOf(Math.round(productsList.get(0).getOnOrderAmt()))));
        orderInfoData.add(new KeyValueModel(Constant.AU_po_number, productsList.get(0).getOnOrderPO()));

        orderInfoData.add(new KeyValueModel(Constant.AU_delivery_date,
                !productsList.get(0).getDeliveryDate().equals("") ?
                        Globals.convertDateFormat(productsList.get(0).getDeliveryDate()) : ""));

        orderInfoData.add(new KeyValueModel(Constant.AU_primary_vendor, productsList.get(0).getSupplierName()));
        orderInfoData.add(new KeyValueModel(Constant.AU_vendor_num, productsList.get(0).getSupplier()));
        orderInfoData.add(new KeyValueModel(Constant.AU_min, String.valueOf(productsList.get(0).getMinStk())));
        orderInfoData.add(new KeyValueModel(Constant.AU_max, String.valueOf(productsList.get(0).getMaxStk())));
        orderInfoData.add(new KeyValueModel(Constant.AU_reorder, String.valueOf(productsList.get(0).getReOrdPoint())));

        orderInfoData.add(new KeyValueModel(Constant.AU_last_received,
                !productsList.get(0).getLastDelDate().equals("") ?
                        Globals.convertDateFormat(productsList.get(0).getLastDelDate()) : ""));


        if (productModel.getTable2().size() > 0) {

            /* Date wise Ascending Order*/
            Collections.sort(productModel.getTable2(), new Comparator<ProductModel.Table2>() {
                @Override
                public int compare(ProductModel.Table2 table2, ProductModel.Table2 t1) {
                    return table2.getDelDate().compareTo(t1.getDelDate());
                }
            });

            /* Allow to add (PO & QTY) if (Delivery data) not match with above (Delivery Date & PO number)*/
            for (int i = 0; i < productModel.getTable2().size(); i++) {
                if (!productsList.get(0).getOnOrderPO().equalsIgnoreCase(productModel.getTable2().get(i).getPoNo()) &&
                        !productsList.get(0).getDeliveryDate().equalsIgnoreCase(productModel.getTable2().get(i).getDelDate())) {
                    orderInfoData.add(new KeyValueModel(Constant.AU_po_qty_on_order, productModel.getTable2().get(i).getPoNo() + "\n" + productModel.getTable2().get(i).getOrderQty()));
                }
            }
        }

        OrderInfoAdapter orderInfoAdapter = new OrderInfoAdapter(mContext);
        orderInfoAdapter.doRefresh(orderInfoData);
        rv_order_info.setHasFixedSize(false);
        rv_order_info.setLayoutManager(new LinearLayoutManager(getActivity()));
        rv_order_info.setAdapter(orderInfoAdapter);

        rv_order_info.setVisibility(View.VISIBLE);
        tv_order_info_not_found.setVisibility(View.GONE);

    }

    /**
     * Local Inv Data
     */
    private void setLocalInvData() {
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
        rv_local_inventory.setHasFixedSize(false);
        rv_local_inventory.setLayoutManager(new LinearLayoutManager(getActivity()));
        rv_local_inventory.setAdapter(localInvListAdapter);

        if (storeStockArrayList.size() > 0) {
            ll_local_inv.setVisibility(View.VISIBLE);
            tv_local_inv_not_found.setVisibility(View.GONE);
        } else {
            ll_local_inv.setVisibility(View.GONE);
            tv_local_inv_not_found.setVisibility(View.VISIBLE);
        }

    }

    /**
     * Sales History Data
     */
    private void setSalesHistoryData() {
        salesByMonths = new ArrayList<>();
        ArrayList<SalesHistoryModel> salesHistoryModel = new ArrayList<>();
        salesByMonths = salesModel.getSalesByMonth();

        tv_branch_code.setText(globals.getBranchCode());

        for (int i = 0; i < salesByMonths.size(); i++) {
            salesHistoryModel.add(new SalesHistoryModel(Globals.getMonthForInt(salesByMonths.get(i).getMon()) + " " +
                    salesByMonths.get(i).getYr(),
                    salesByMonths.get(i).getStoreQty(),
                    salesByMonths.get(i).getCompQty(), salesByMonths.get(i).getYr()));
        }

        SalesHistoryListAdapter storeListAdapter = new SalesHistoryListAdapter(getActivity());
        storeListAdapter.doRefresh(salesHistoryModel);
        rv_sales_history.setHasFixedSize(false);
        rv_sales_history.setLayoutManager(new LinearLayoutManager(getActivity()));
        rv_sales_history.setAdapter(storeListAdapter);

        ll_sales_history_header.setVisibility(View.VISIBLE);
        rv_sales_history.setVisibility(View.VISIBLE);
        tv_sales_history_not_found.setVisibility(View.GONE);
    }

    /**
     * Related Data
     */
    private void setRelatedData() {

        relatedProductArrayList.clear();
        relatedProductArrayList = relatedModel.getRelatedProducts();

        RelatedProductsAdapter relatedProductsAdapter = new RelatedProductsAdapter(getActivity(), this);
        relatedProductsAdapter.doRefresh(relatedProductArrayList);

        rv_related_products.setHasFixedSize(false);
        rv_related_products.setLayoutManager(new LinearLayoutManager(getActivity()));
        rv_related_products.setAdapter(relatedProductsAdapter);

        rv_related_products.setVisibility(View.VISIBLE);
        tv_related_not_found.setVisibility(View.GONE);

    }

    /**
     * Handle Click of Floating Back Button
     */
    @SuppressLint("RestrictedApi")
    @OnClick(R.id.fab_prev_item)
    public void fabClick() {
        data = globals.getPreviousProductCode();
        isFromRelated = false;
        globals.isFromMenu = false;
        doRequestForGetProductDetail();
    }

    /**
     * Handle Click event of Related Items
     */
    @Override
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
        data = relatedProductArrayList.get(i).getSku();
        isFromRelated = true;
        doRequestForGetProductDetail();
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mContext = null;
    }

}
