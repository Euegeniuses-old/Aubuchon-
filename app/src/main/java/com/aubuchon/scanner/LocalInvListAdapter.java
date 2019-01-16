package com.aubuchon.scanner;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.aubuchon.R;
import com.aubuchon.model.ProductDetailsModel;

import java.util.ArrayList;

public class LocalInvListAdapter extends RecyclerView.Adapter<LocalInvListAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<ProductDetailsModel.StoreStock> mDataSetFilterData;

    LocalInvListAdapter(Context context) {
        this.context = context;
    }

    void doRefresh(ArrayList<ProductDetailsModel.StoreStock> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private LocalInvListAdapter mAdapter;

        TextView tv_store, tv_num, tv_qty;
        LinearLayout ll_local_inv;
        View view_separator;
        private ProductDetailsModel.StoreStock storeStock;

        ViewHolder(View itemView, final LocalInvListAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            ll_local_inv = itemView.findViewById(R.id.ll_local_inv);
            tv_store = itemView.findViewById(R.id.tv_store);
            tv_num = itemView.findViewById(R.id.tv_num);
            tv_qty = itemView.findViewById(R.id.tv_qty);
            view_separator = itemView.findViewById(R.id.view_separator);
            itemView.setOnClickListener(this);
        }

        void setDataToView(ProductDetailsModel.StoreStock storeStock, final int position) {

            tv_store.setText(storeStock.getName());
            tv_num.setText(storeStock.getStore());
            tv_qty.setText(String.valueOf(storeStock.getQty()));

            /*Handle visibility of Black Horizontal Separator line*/
            view_separator.setVisibility((position == 4) ? View.VISIBLE : View.GONE);

            /*Handle Background color*/
            if (position % 2 == 0) {
                ll_local_inv.setBackgroundColor(Color.GRAY);
            } else {
                ll_local_inv.setBackgroundColor(Color.WHITE);
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
        ProductDetailsModel.StoreStock stock = mDataSetFilterData.get(position);
        try {
            holder.setDataToView(stock, position);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return mDataSetFilterData.size();
    }

    /*  public ProductDetailModel.Product getDataByPosition(int position) {
        if (mDataSetFilterData != null && mDataSetFilterData.size() > 0)
            return mDataSetFilterData.get(position);
        return null;
    }*/

}
