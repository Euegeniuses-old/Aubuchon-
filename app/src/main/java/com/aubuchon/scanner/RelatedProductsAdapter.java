package com.aubuchon.scanner;

import android.content.Context;
import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ImageView;
import android.widget.TextView;

import com.aubuchon.R;
import com.aubuchon.model.ProductDetailsModel;
import com.aubuchon.utility.GlideApp;

import java.util.ArrayList;

public class RelatedProductsAdapter extends RecyclerView.Adapter<RelatedProductsAdapter.ViewHolder> {

    private Context context;
    private AdapterView.OnItemClickListener onItemClickListener;
    private ArrayList<ProductDetailsModel.RelatedProduct> mDataSetFilterData;

    RelatedProductsAdapter(Context context, AdapterView.OnItemClickListener onItemClickListener) {
        this.context = context;
        this.onItemClickListener = onItemClickListener;
    }

    void doRefresh(ArrayList<ProductDetailsModel.RelatedProduct> dataSet) {
        mDataSetFilterData = dataSet;
        notifyDataSetChanged();
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View v = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.related_products_item_list, viewGroup, false);
        return new ViewHolder(v, this);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        ProductDetailsModel.RelatedProduct relatedProduct = mDataSetFilterData.get(position);
        try {
            holder.setDataToView(relatedProduct, position);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public int getItemCount() {
        return mDataSetFilterData.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        private RelatedProductsAdapter mAdapter;
        ImageView iv_product;
        TextView tv_web_desc, tv_retail_prize;

        ViewHolder(View itemView, final RelatedProductsAdapter mAdapter) {
            super(itemView);
            this.mAdapter = mAdapter;

            iv_product = itemView.findViewById(R.id.iv_product);
            tv_web_desc = itemView.findViewById(R.id.tv_web_desc);
            tv_retail_prize = itemView.findViewById(R.id.tv_retail_prize);

            itemView.setOnClickListener(this);
        }

        void setDataToView(ProductDetailsModel.RelatedProduct relatedProduct, final int position) {

            GlideApp.with(context).load(relatedProduct.getImage()).placeholder(R.drawable.camera).into(iv_product);

            tv_web_desc.setText(relatedProduct.getWebDesc());
            tv_retail_prize.setText(String.valueOf(relatedProduct.getRetailPrice()) + "$");

           /* if (position % 2 == 0) {
                tv_store.setBackgroundColor(Color.GRAY);
                tv_num.setBackgroundColor(Color.GRAY);
                tv_qty.setBackgroundColor(Color.GRAY);
            } else {
                tv_store.setBackgroundColor(Color.WHITE);
                tv_num.setBackgroundColor(Color.WHITE);
                tv_qty.setBackgroundColor(Color.WHITE);
            }*/
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

    private void onItemHolderClick(RelatedProductsAdapter.ViewHolder holder) {
        if (onItemClickListener != null)
            onItemClickListener.onItemClick(null, holder.itemView, holder.getAdapterPosition(), holder.getItemId());
    }

}
