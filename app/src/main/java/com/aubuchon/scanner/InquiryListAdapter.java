package com.aubuchon.scanner;

import android.content.Context;
import android.graphics.Color;
import android.support.annotation.NonNull;
import android.support.v7.widget.AppCompatTextView;
import android.support.v7.widget.RecyclerView;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.aubuchon.R;
import com.aubuchon.model.KeyValueModel;
import com.aubuchon.utility.Constant;
import com.iarcuschin.simpleratingbar.SimpleRatingBar;

import java.util.ArrayList;

public class InquiryListAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<KeyValueModel> mDataSetFilterData;

    private static final int LAYOUT_ONE = 0;
    private static final int LAYOUT_TWO = 1;
    private int count;


    InquiryListAdapter(Context context, int count) {
        this.context = context;
        this.count = count;
    }

    void doRefresh(ArrayList<KeyValueModel> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    @Override
    public int getItemViewType(int position) {
        if (position == count)
            return LAYOUT_TWO;
        else
            return LAYOUT_ONE;
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private InquiryListAdapter mAdapter;

        LinearLayout ll_inquiry_item;
        TextView tv_key, tv_value;

        ViewHolder(View itemView, final InquiryListAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            ll_inquiry_item = itemView.findViewById(R.id.ll_inquiry_item);
            tv_key = itemView.findViewById(R.id.tv_key);
            tv_value = itemView.findViewById(R.id.tv_value);

            itemView.setOnClickListener(this);
        }

        void setDataToView(KeyValueModel pDetails, final int position) {

            tv_key.setText(pDetails.getKey());
            /*Handle an Empty Data*/
            if (pDetails.getValue().isEmpty() || pDetails.getValue().equals("")) {
                tv_value.setText(" - ");
            } else {
                tv_value.setText(pDetails.getValue());
            }

            if (position % 2 == 0) {
                ll_inquiry_item.setBackgroundColor(Color.GRAY);
            } else {
                ll_inquiry_item.setBackgroundColor(Color.WHITE);
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
    public RecyclerView.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        /*View v = LayoutInflater.from(parent.getContext()).inflate(R.layout.inquiry_list_item, parent, false);
        return new ViewHolder(v, this);*/

        View view;
        RecyclerView.ViewHolder viewHolder;

        if (viewType == LAYOUT_ONE) {
            view = LayoutInflater.from(parent.getContext()).inflate(R.layout.inquiry_list_item, parent, false);
            viewHolder = new ViewHolderOne(view);
        } else {
            view = LayoutInflater.from(parent.getContext()).inflate(R.layout.star_view_holder, parent, false);
            viewHolder = new ViewHolderTwo(view);
        }

        return viewHolder;

    }

    @Override
    public void onBindViewHolder(@NonNull RecyclerView.ViewHolder viewHolder, int position) {
        KeyValueModel keyValueModel = mDataSetFilterData.get(position);
        if (viewHolder.getItemViewType() == LAYOUT_ONE) {
            ViewHolderOne itemHolder = (ViewHolderOne) viewHolder;
            itemHolder.setDataToView(keyValueModel, position);
        } else if (viewHolder.getItemViewType() == LAYOUT_TWO) {

            /*KeyValueModel valueModel = mDataSetFilterData.get(position);*/

            ViewHolderTwo starViewHolder = (ViewHolderTwo) viewHolder;
            starViewHolder.setDataToView(keyValueModel, position);
        }

    }

    //****************  VIEW HOLDER 1 ******************//

    public class ViewHolderOne extends RecyclerView.ViewHolder {

        LinearLayout ll_inquiry_item;
        TextView tv_key, tv_value;

        ViewHolderOne(View itemView) {
            super(itemView);

            ll_inquiry_item = itemView.findViewById(R.id.ll_inquiry_item);
            tv_key = itemView.findViewById(R.id.tv_key);
            tv_value = itemView.findViewById(R.id.tv_value);

        }

        void setDataToView(KeyValueModel pDetails, final int position) {
            tv_key.setText(pDetails.getKey());
            if (pDetails.getValue().isEmpty() || pDetails.getValue().equals("")) {
                tv_value.setText(" - ");
            } else {
                tv_value.setText(pDetails.getValue());
            }

            if (position % 2 == 0) {
                ll_inquiry_item.setBackgroundColor(Color.GRAY);
            } else {
                ll_inquiry_item.setBackgroundColor(Color.WHITE);
            }

            if (pDetails.getKey().equalsIgnoreCase(Constant.AU_web_desc)) {
                ll_inquiry_item.setBackgroundColor(Color.TRANSPARENT);
                tv_key.setVisibility(View.GONE);
                tv_value.setGravity(Gravity.CENTER_HORIZONTAL);
                tv_value.setText(pDetails.getValue());
            } else {
                tv_key.setVisibility(View.VISIBLE);
            }

        }

    }


    //****************  VIEW HOLDER 2 ******************//

    public class ViewHolderTwo extends RecyclerView.ViewHolder {

        SimpleRatingBar rating;
        AppCompatTextView tv_rating;
        AppCompatTextView tv_web_desc;

        ViewHolderTwo(View itemView) {
            super(itemView);

            rating = itemView.findViewById(R.id.rating);
            tv_rating = itemView.findViewById(R.id.tv_rating);
            tv_web_desc = itemView.findViewById(R.id.tv_web_desc);
            tv_web_desc.setVisibility(View.GONE);
        }

        void setDataToView(KeyValueModel pDetails, final int position) {
            if (pDetails.getKey().equalsIgnoreCase(Constant.AU_rating)) {
                rating.setRating(Float.parseFloat(pDetails.getValue()));
                tv_rating.setText(pDetails.getValue());
                /*tv_web_desc.setText();*/
            }
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
