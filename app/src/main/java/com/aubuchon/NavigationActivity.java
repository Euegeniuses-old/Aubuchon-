package com.aubuchon;

import android.content.Intent;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.AppCompatImageView;
import android.support.v7.widget.Toolbar;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.aubuchon.scanner.ItemDetailFragment;
import com.aubuchon.scanner.ScannerActivity;
import com.aubuchon.utility.Constant;
import com.aubuchon.utility.Globals;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class NavigationActivity extends AppCompatActivity {

    private static final String BACK_STACK_ROOT_TAG = "root_fragment";

    public static final int SCAN_BARCODE_REQUEST = 1002;

    @BindView(R.id.toolbar)
    Toolbar toolbar;
    @BindView(R.id.toolbar_title)
    public TextView toolbar_title;
    @BindView(R.id.iv_home)
    AppCompatImageView iv_home;
    Globals globals;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_navigation);
        ButterKnife.bind(this);
        globals = (Globals) getApplicationContext();
        addFragmentOnTop(HomeFragment.newInstance());
    }

    public void setToolbar() {
        setSupportActionBar(toolbar);
        if (getSupportActionBar() != null) {
            getSupportActionBar().setDisplayShowHomeEnabled(true);
            getSupportActionBar().setDisplayShowTitleEnabled(false);

           /* List<Fragment> frags = getSupportFragmentManager().getFragments();
            for (Fragment f : frags) {
                if (!(f instanceof HomeFragment)) {
                    toolbar_title.setText(Globals.getToolbarTitle());
                } else {
                    toolbar_title.setText("");
                }
            }*/

            // Handle Navigation Option Click
            toolbar.setNavigationOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    showFilterPopup();
                }
            });

            // Handle Barcode Image (Top Right) Click
            iv_home.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                  /*  List<Fragment> frags = getSupportFragmentManager().getFragments();
                    for (Fragment f : frags) {
                        if (!(f instanceof HomeFragment)) {
                            // onBackPressed();

                            //Old Functionality commented on 04/01/2019
                            *//*setToolbar();
                            toolbar_title.setText("");
                            getSupportFragmentManager().popBackStack(BACK_STACK_ROOT_TAG, FragmentManager.POP_BACK_STACK_INCLUSIVE);
                            addFragmentOnTop(HomeFragment.newInstance());*//*

                        }

                    }*/

                    Intent intent = new Intent(NavigationActivity.this, ScannerActivity.class);
                    startActivityForResult(intent, SCAN_BARCODE_REQUEST);

                }
            });
        }
    }

    private void checkHomeFragment() {
        List<Fragment> frags = getSupportFragmentManager().getFragments();
        for (Fragment f : frags) {
            if (!(f instanceof HomeFragment)) {
                addFragmentOnTop(HomeFragment.newInstance());
                //onBackPressed();
            }
        }
    }

    /**
     * Add a fragment on top of the current tab
     */
    public void addFragmentOnTop(Fragment fragment) {
        getSupportFragmentManager()
                .beginTransaction()
                .replace(R.id.container, fragment)
                .commit();
    }


    private void showFilterPopup() {
        LayoutInflater inflater = (LayoutInflater) getSystemService(LAYOUT_INFLATER_SERVICE);
        View popupView = inflater.inflate(R.layout.layout_popup_window, null);
        int width = LinearLayout.LayoutParams.WRAP_CONTENT;
        int height = LinearLayout.LayoutParams.WRAP_CONTENT;
        final PopupWindow popupWindow = new PopupWindow(popupView, width, height, true);
        popupWindow.setBackgroundDrawable(new BitmapDrawable());
        popupWindow.setOutsideTouchable(true);
        popupWindow.showAtLocation(toolbar, Gravity.TOP | Gravity.START, 10, Globals.getStatusBarHeight());

        TextView tv_popup_home = popupView.findViewById(R.id.tv_popup_home);
        TextView tv_popup_product_info = popupView.findViewById(R.id.tv_popup_product_info);

        tv_popup_home.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                List<Fragment> frags = getSupportFragmentManager().getFragments();
                for (Fragment f : frags) {
                    if (!(f instanceof HomeFragment)) {
                        getSupportFragmentManager().popBackStack(BACK_STACK_ROOT_TAG, FragmentManager.POP_BACK_STACK_INCLUSIVE);
                        addFragmentOnTop(HomeFragment.newInstance());
                        toolbar_title.setText("");
                    }
                }
                popupWindow.dismiss();
            }
        });

        tv_popup_product_info.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

                if (globals.getPreviousProductCode() != null && !globals.getPreviousProductCode().isEmpty()) {
                    List<Fragment> frags = getSupportFragmentManager().getFragments();
                    for (Fragment f : frags) {
                        if (f instanceof HomeFragment) {
                            globals.isFromMenu = true;
                            addFragmentOnTop(ItemDetailFragment.newInstance(globals.getCurrentProductCode()));
                        } else if (f instanceof ItemDetailFragment) {
                            globals.isFromMenu = true;
                            addFragmentOnTop(ItemDetailFragment.newInstance(globals.getPreviousProductCode()));
                        }
                    }
                }

                //  addFragmentOnTop(ItemDetailFragment.newInstance(globals.getPreviousProductCode()));

                popupWindow.dismiss();
            }
        });
    }

    @Override
    public void onBackPressed() {
        // Pop off everything up to and including the current tab
        //FragmentManager fragmentManager = getSupportFragmentManager();
        /*if (fragmentManager.getBackStackEntryCount() == 0){

        }
        else {
            super.onBackPressed();
        }*/

        //clear toolbar
        List<Fragment> frags = getSupportFragmentManager().getFragments();
        for (Fragment f : frags) {
            if (f instanceof HomeFragment) {
                toolbar_title.setText("");
                //finish();
                super.onBackPressed();
            } else {
                addFragmentOnTop(HomeFragment.newInstance());
                toolbar_title.setText("");
            }
        }
    }


    // Handle Result come from Scanning
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        String scannedCode = "";
        if (requestCode == SCAN_BARCODE_REQUEST && data != null) {

            scannedCode = data.getExtras().getString(Constant.AU_Data);

            List<Fragment> frags = getSupportFragmentManager().getFragments();
            for (Fragment f : frags) {
                if (!(f instanceof HomeFragment)) {
                /*    getSupportFragmentManager().popBackStack(BACK_STACK_ROOT_TAG, FragmentManager.POP_BACK_STACK_INCLUSIVE);
                    addFragmentOnTop(HomeFragment.newInstance());*/

                    addFragmentOnTop(ItemDetailFragment.newInstance(scannedCode));
                }else{
                    toolbar_title.setText("");
                    scannedCode = data.getExtras().getString(Constant.AU_Data);
                    toolbar_title.setText(String.format(getString(R.string.text_sku), scannedCode));
                }
            }

            /*setToolbar();
            toolbar_title.setText("");
            scannedCode = data.getExtras().getString(Constant.AU_Data);
            toolbar_title.setText(String.format(getString(R.string.text_sku), scannedCode));*/

        }
    }

}
