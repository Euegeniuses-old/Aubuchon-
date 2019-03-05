package com.developer.weatcb.scanner;

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

import com.developer.R;
import com.developer.weatcb.model.SalesHistoryModel;

import java.util.ArrayList;

public class SalesHistoryListAdapter extends RecyclerView.Adapter<SalesHistoryListAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<SalesHistoryModel> mDataSetFilterData;

    SalesHistoryListAdapter(Context context) {
        this.context = context;
    }

    void doRefresh(ArrayList<SalesHistoryModel> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private SalesHistoryListAdapter mAdapter;

        TextView tv_sales_month, tv_sales_store, tv_sales_company;
        LinearLayout ll_sales_history_item;

        ViewHolder(View itemView, final SalesHistoryListAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            ll_sales_history_item = itemView.findViewById(R.id.ll_sales_history_item);
            tv_sales_month = itemView.findViewById(R.id.tv_sales_month);
            tv_sales_store = itemView.findViewById(R.id.tv_sales_store);
            tv_sales_company = itemView.findViewById(R.id.tv_sales_company);

            itemView.setOnClickListener(this);
        }

        void setDataToView(SalesHistoryModel sDetails, final int position) {
            tv_sales_month.setText(sDetails.getMonth());
            tv_sales_store.setText(String.valueOf(sDetails.getStore()));
            tv_sales_company.setText(String.valueOf(sDetails.getCompany()));

            if (position % 2 == 0) {
                ll_sales_history_item.setBackgroundColor(Color.GRAY);
            } else {
                ll_sales_history_item.setBackgroundColor(Color.WHITE);
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
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.sales_history_list_item, parent, false);
        return new ViewHolder(v, this);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        SalesHistoryModel salesHistoryModel = mDataSetFilterData.get(position);
        try {
            holder.setDataToView(salesHistoryModel, position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return mDataSetFilterData.size();
    }


}
