package com.aubuchon.scanner;

import android.content.Context;
import android.support.v7.widget.AppCompatButton;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.SparseBooleanArray;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TextView;

import com.aubuchon.R;
import com.aubuchon.model.ProductDetailModel;
import com.aubuchon.model.ProductDetailModel.Product;
import com.aubuchon.utility.Constant;
import com.aubuchon.utility.Globals;

import android.graphics.Color;
import android.support.annotation.NonNull;


import java.util.ArrayList;
import java.util.Date;


public class LocalInvListAdapter extends RecyclerView.Adapter<LocalInvListAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<ProductDetailModel.Product> mDataSetFilterData;
    private Product pDetails;


    public LocalInvListAdapter(Context context) {
        this.context = context;
    }

    public void doRefresh(ArrayList<ProductDetailModel.Product> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private LocalInvListAdapter mAdapter;

        TextView tv_store, tv_num, tv_qty;
        private Product pDetails;

        ViewHolder(View itemView, final LocalInvListAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            tv_store = itemView.findViewById(R.id.tv_store);

            tv_num = itemView.findViewById(R.id.tv_num);

            tv_qty = itemView.findViewById(R.id.tv_qty);
            itemView.setOnClickListener(this);
        }

        void setDataToView(ProductDetailModel.Product pDetails, final int position) {
            if (position % 2 == 0) {
                tv_store.setBackgroundColor(Color.GRAY);
                tv_num.setBackgroundColor(Color.GRAY);
                tv_qty.setBackgroundColor(Color.GRAY);
            } else {
                tv_store.setBackgroundColor(Color.WHITE);
                tv_num.setBackgroundColor(Color.WHITE);
                tv_qty.setBackgroundColor(Color.WHITE);
            }
        }

        @Override
        public void onClick(View v) {
            switch (v.getId()) {
                default:
                    mAdapter.onItemHolderClick(ViewHolder.this);
            }
        }
    }


    public void setOnItemClickListener(AdapterView.OnItemClickListener onItemClickListener) {
        this.onItemClickListener = onItemClickListener;
    }

    private void onItemHolderClick(ViewHolder holder) {
        if (onItemClickListener != null)
            onItemClickListener.onItemClick(null, holder.itemView, holder.getAdapterPosition(), holder.getItemId());
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.local_inv_item_layout, parent, false);
        return new ViewHolder(v, this);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        ProductDetailModel.Product product = mDataSetFilterData.get(position);
        try {
            holder.setDataToView(product, position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return 10;//mDataSetFilterData.size();
    }

    public ProductDetailModel.Product getDataByPosition(int position) {
        if (mDataSetFilterData != null && mDataSetFilterData.size() > 0)
            return mDataSetFilterData.get(position);
        return null;
    }


}
