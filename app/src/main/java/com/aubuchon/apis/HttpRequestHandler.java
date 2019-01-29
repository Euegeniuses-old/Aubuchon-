package com.aubuchon.apis;

import android.content.Context;
import android.graphics.Color;

import com.aubuchon.utility.Constant;
import com.aubuchon.utility.Globals;
import com.loopj.android.http.AsyncHttpClient;
import com.loopj.android.http.AsyncHttpResponseHandler;
import com.loopj.android.http.RequestParams;
import com.orhanobut.logger.Logger;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.io.FileNotFoundException;

import cc.cloudist.acplibrary.ACProgressConstant;
import cc.cloudist.acplibrary.ACProgressFlower;
import cz.msebera.android.httpclient.entity.StringEntity;


public class HttpRequestHandler {
    private Globals globals = (Globals) Globals.getContext();
    private static final String HEADER_TYPE_JSON = "application/json";

    private static final String AUTHORIZATION_HEADER = "authorization";
    private static final String AUTHORIZATION_HEADER_VALUE = "Bearer b04a4a68ee5bf04d9582e27011601ac8";

    private static HttpRequestHandler mInstance = null;
    private final AsyncHttpClient client;
    public String TAG = getClass().getName();

    private HttpRequestHandler() {
        client = new AsyncHttpClient();
        client.setTimeout(30000);
    }

    public static HttpRequestHandler getInstance() {
        if (mInstance == null) {
            mInstance = new HttpRequestHandler();
        }
        return mInstance;
    }

    public void get(Context context, String url, AsyncHttpResponseHandler responseHandler) {
        client.addHeader(AUTHORIZATION_HEADER, AUTHORIZATION_HEADER_VALUE);
        StringEntity entity = new StringEntity("", "UTF-8");
        client.get(context, url, entity, HEADER_TYPE_JSON, responseHandler);
    }

    void post(Context context, String url, JSONObject params, AsyncHttpResponseHandler responseHandler) {
        try {
            Logger.e(url);
            Logger.json(params.toString());
            StringEntity entity = new StringEntity(params.toString(), "UTF-8");
            client.post(context, url, entity, HEADER_TYPE_JSON, responseHandler);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void postWithReqestParam(String url, RequestParams params, AsyncHttpResponseHandler responseHandler) {
        Logger.e("Server Url:=> " + url);
        Logger.d(params.toString());
        client.post(url, params, responseHandler);
    }

    public void cancelRequest(Context context) {
        client.cancelRequests(context, true);
    }

    ACProgressFlower getProgressBar(Context context) {
        final ACProgressFlower dialog = new ACProgressFlower.Builder(context)
                .direction(ACProgressConstant.DIRECT_CLOCKWISE)
                .petalThickness(5)
                .speed(15f)
                .themeColor(Color.WHITE)
                .fadeColor(Color.DKGRAY).build();
        dialog.setCancelable(false);
        dialog.setCanceledOnTouchOutside(false);
        return dialog;
    }

    public ACProgressFlower getProgressBarWithText(Context context, String msg) {
        final ACProgressFlower dialog = new ACProgressFlower.Builder(context)
                .direction(ACProgressConstant.DIRECT_CLOCKWISE)
                .petalThickness(5)
                .themeColor(Color.WHITE)
                .text(msg)
                .fadeColor(Color.DKGRAY).build();
        dialog.setCancelable(false);
        return dialog;
    }

    public RequestParams getUploadImageParams(File selectedImage) {
        RequestParams params = new RequestParams();
        try {
            params.put(Constant.AU_Photo, selectedImage);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return params;
    }

    public RequestParams getProductDetailParams(String branchCode, String data) {
        RequestParams params = new RequestParams();

        params.put(Constant.AU_branchcode, branchCode);
        params.put(Constant.AU_data, data);

        return params;
    }

    public JSONObject getCheckPublicIpParams(String publicIP) {
        JSONObject params = new JSONObject();
        try {
            params.put(Constant.AU_IpAddress, publicIP);
        } catch (JSONException e) {
            e.printStackTrace();
        }
        return params;
    }


}
