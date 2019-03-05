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
import com.developer.weatcb.model.KeyValueModel;

import java.util.ArrayList;

public class OrderInfoAdapter extends RecyclerView.Adapter<OrderInfoAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<KeyValueModel> mDataSetFilterData;

    OrderInfoAdapter(Context context) {
        this.context = context;
    }

    void doRefresh(ArrayList<KeyValueModel> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        private OrderInfoAdapter mAdapter;

        LinearLayout ll_inquiry_item;
        TextView tv_key, tv_value;

        ViewHolder(View itemView, final OrderInfoAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            ll_inquiry_item = itemView.findViewById(R.id.ll_inquiry_item);
            tv_key = itemView.findViewById(R.id.tv_key);
            tv_value = itemView.findViewById(R.id.tv_value);

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

    }


    @NonNull
    @Override
    public OrderInfoAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.inquiry_list_item, viewGroup, false);
        return new ViewHolder(v, this);
    }

    @Override
    public void onBindViewHolder(@NonNull OrderInfoAdapter.ViewHolder viewHolder, int position) {
        KeyValueModel keyValueModel = mDataSetFilterData.get(position);
        try {
            viewHolder.setDataToView(keyValueModel, position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return mDataSetFilterData.size();
    }
}
