package com.aubuchon.utility;

import android.app.Activity;
import android.app.Application.ActivityLifecycleCallbacks;
import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.multidex.MultiDexApplication;
import android.util.Base64;
import android.view.Gravity;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.aubuchon.R;
import com.orhanobut.logger.AndroidLogAdapter;
import com.orhanobut.logger.Logger;

import java.io.UnsupportedEncodingException;

import es.dmoral.toasty.Toasty;


public class Globals extends MultiDexApplication implements ActivityLifecycleCallbacks {

    SharedPreferences sp;
    SharedPreferences.Editor editor;
    private static String currentProductCode, previousProductCode;
    public static String TAG = "Globals";
    static Context context;

    public boolean isFromMenu = false;
    public String passCode = "";
    public String barCode = "";

    private static final int MINUTES_IN_AN_HOUR = 60;
    private static final int SECONDS_IN_A_MINUTE = 60;

    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();

        Logger.addLogAdapter(new AndroidLogAdapter() {
            @Override
            public boolean isLoggable(int priority, String tag) {
                return true/*BuildConstants.isDebuggable*/;
            }
        });
    }


    public static Context getContext() {
        return context;
    }


    @Override
    public void onActivityCreated(Activity activity, Bundle savedInstanceState) {

    }

    @Override
    public void onActivityStarted(Activity activity) {

    }

    @Override
    public void onActivityResumed(Activity activity) {

    }

    @Override
    public void onActivityPaused(Activity activity) {

    }

    @Override
    public void onActivityStopped(Activity activity) {

    }

    @Override
    public void onActivitySaveInstanceState(Activity activity, Bundle outState) {

    }

    @Override
    public void onActivityDestroyed(Activity activity) {

    }

    public SharedPreferences getSharedPref() {
        return sp = (sp == null) ? getSharedPreferences(Constant.MM_secrets, Context.MODE_PRIVATE) : sp;
    }

    public SharedPreferences.Editor getEditor() {
        return editor = (editor == null) ? getSharedPref().edit() : editor;
    }

    private static Toast toast;

    public static void showToast(Context context, String message) {
        if (message == null || message.isEmpty() || context == null)
            return;

        //1st way to instantly update Toast message: with toasty library
        if (toast == null) {
            toast = Toasty.normal(context, message);
        }
        View v = toast.getView();
        if (v != null) {
            TextView tv = (TextView) v.findViewById(R.id.toast_text);
            if (tv != null)
                tv.setText(message);
        }
        toast.setGravity(Gravity.CENTER, 0, 0);
        toast.show();

    }


    public static String getBase64EncodedString(String value) {
        try {
            byte[] data = value.getBytes("UTF-8");
            return Base64.encodeToString(data, Base64.NO_WRAP);
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return value;
        }
    }

    public String getCurrentProductCode() {
        return currentProductCode;
    }

    public void setCurrentProductCode(String currentProductCode) {
        Globals.currentProductCode = currentProductCode;
    }

    public String getPreviousProductCode() {
        return previousProductCode;
    }

    public void setPreviousProductCode(String previousProductCode) {
        Globals.previousProductCode = previousProductCode;
    }

    public static String getToolbarTitle() {
        if (previousProductCode != null && !previousProductCode.isEmpty()) {
            return "SKU: " + previousProductCode;
        } else if (currentProductCode != null && !currentProductCode.isEmpty()) {
            return "SKU: " + currentProductCode;
        } else return "";
    }

    public static int getStatusBarHeight() {
        int result = 0;
        int resourceId = context.getResources().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            result = context.getResources().getDimensionPixelSize(resourceId);
        }
        return result;
    }

}
