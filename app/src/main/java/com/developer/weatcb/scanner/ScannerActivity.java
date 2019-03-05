package com.developer.weatcb.scanner;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.ViewGroup;

import com.developer.R;
import com.developer.weatcb.utility.Constant;
import com.google.gson.Gson;
import com.google.zxing.Result;
import com.orhanobut.logger.Logger;

import butterknife.ButterKnife;
import me.dm7.barcodescanner.zxing.ZXingScannerView;

public class ScannerActivity extends AppCompatActivity implements ZXingScannerView.ResultHandler {

    private static final String FLASH_STATE = "FLASH_STATE";
    private static final int REQUEST_CAMERA_PERMISSION = 1111;

    private ZXingScannerView mScannerView;
    private boolean mFlash;
    String resultString;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        resultString = "";
        setContentView(R.layout.activity_scanner);
        ButterKnife.bind(this);
        init();
    }

    // initialize all the necessary elements
    private void init() {
        ViewGroup contentFrame = findViewById(R.id.content_frame);
        mScannerView = new ZXingScannerView(this);
        contentFrame.addView(mScannerView);
    }

    @Override
    public void onResume() {
        super.onResume();
        mScannerView.setResultHandler(ScannerActivity.this);

        //Manually Specify Scanner code format
      /*  List<BarcodeFormat> formats = new ArrayList<>();
        formats.add(BarcodeFormat.UPC_A);
        formats.add(BarcodeFormat.UPC_E);
        mScannerView.setFormats(formats);*/

        // You can optionally set aspect ratio tolerance level
        // that is used in calculating the optimal Camera preview size
        mScannerView.setAspectTolerance(0.2f);
        mScannerView.startCamera();
        mScannerView.setFlash(mFlash);

    }

    @Override
    public void onPause() {
        super.onPause();
        mScannerView.stopCamera();
    }

    @Override
    public void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putBoolean(FLASH_STATE, mFlash);
    }

    @Override
    public void handleResult(Result rawResult) {
       /* Toast.makeText(this, "Contents = " + rawResult.getText() +
                ", Format = " + rawResult.getBarcodeFormat().toString(), Toast.LENGTH_SHORT).show();*/
        resultString = rawResult.getText();
        Logger.json(new Gson().toJson(rawResult));

        /*Result New Flow*/
        if (resultString != null && !resultString.isEmpty()) {
            Intent result = new Intent();
            result.putExtra(Constant.AU_Data, resultString);
            setResult(RESULT_OK, result);
            finish();
        }

    }

   /* @OnClick(R.id.btn_rescan)
    public void rescanBarCode(View v) {
        // Note:
        // * Wait 2 seconds to resume the preview.
        // * On older devices continuously stopping and resuming camera preview can result in freezing the app.
        // * I don't know why this is the case but I don't have the time to figure out.
      *//*  Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                mScannerView.resumeCameraPreview(ScannerActivity.this);
            }
        }, 2000);*//*
        resultString = "";
        mScannerView.resumeCameraPreview(ScannerActivity.this);
    }

    @OnClick(R.id.btn_ok)
    public void goBackToMainScreen(View v) {
        if (resultString != null && !resultString.isEmpty()) {
            Intent result = new Intent();
            result.putExtra(Constant.AU_Data, resultString);
            setResult(RESULT_OK, result);
            finish();
        }
    }*/

}
