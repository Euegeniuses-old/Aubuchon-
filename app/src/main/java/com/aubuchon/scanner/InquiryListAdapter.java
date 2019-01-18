package com.aubuchon.scanner;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.v7.widget.AppCompatRatingBar;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.TextView;

import com.aubuchon.R;
import com.aubuchon.model.KeyValueModel;

import java.util.ArrayList;

public class InquiryListAdapter extends RecyclerView.Adapter<InquiryListAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<KeyValueModel> mDataSetFilterData;


    InquiryListAdapter(Context context) {
        this.context = context;
    }

    void doRefresh(ArrayList<KeyValueModel> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private InquiryListAdapter mAdapter;

        TextView tv_key, tv_value;
        AppCompatRatingBar rating;

        ViewHolder(View itemView, final InquiryListAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            tv_key = itemView.findViewById(R.id.tv_key);
            tv_value = itemView.findViewById(R.id.tv_value);
            rating = itemView.findViewById(R.id.rating);

            itemView.setOnClickListener(this);
        }

        void setDataToView(KeyValueModel pDetails, final int position) {

            tv_key.setText(pDetails.getKey());

            /*Handle Rating Data*/
            if (pDetails.getKey().equalsIgnoreCase("Rating")) {
                rating.setRating(Float.parseFloat(pDetails.getValue()));
                rating.setVisibility(View.VISIBLE);
                tv_value.setVisibility(View.GONE);
            } else {
                rating.setVisibility(View.GONE);
                tv_value.setVisibility(View.VISIBLE);
            }

            /*Handle an Empty Data*/
            if (pDetails.getValue().equalsIgnoreCase("") || pDetails.getValue().equalsIgnoreCase("0.0")) {
                tv_value.setText(" - ");
            } else {
                tv_value.setText(pDetails.getValue());
            }


            if (position % 2 == 0) {
                tv_key.setBackgroundColor(Color.GRAY);
                tv_value.setBackgroundColor(Color.GRAY);
            } else {
                tv_key.setBackgroundColor(Color.WHITE);
                tv_value.setBackgroundColor(Color.WHITE);
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
        View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.inquiry_list_item, parent, false);
        return new ViewHolder(v, this);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        KeyValueModel product = mDataSetFilterData.get(position);
        try {
            holder.setDataToView(product, position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return mDataSetFilterData.size();
    }

    public KeyValueModel getDataByPosition(int position) {
        if (mDataSetFilterData != null && mDataSetFilterData.size() > 0)
            return mDataSetFilterData.get(position);
        return null;
    }

}
