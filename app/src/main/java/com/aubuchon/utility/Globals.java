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
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import es.dmoral.toasty.Toasty;

public class Globals extends MultiDexApplication implements ActivityLifecycleCallbacks {

    SharedPreferences sp;
    SharedPreferences.Editor editor;
    private static String currentProductCode, previousProductCode;
    public static String TAG = "Globals";
    static Context context;

    private String branchCode = "";

    public boolean isFromMenu = false;
    public String passCode = "";
    public String barCode = "";

    public static String months[];

    @Override
    public void onCreate() {
        super.onCreate();
        context = getApplicationContext();

        months = context.getResources().getStringArray(R.array.arr_month);

        Logger.addLogAdapter(new AndroidLogAdapter() {
            @Override
            public boolean isLoggable(int priority, String tag) {
                return false;
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

    public static String getMonthForInt(int m) {
        return months[m - 1];
    }

    public String getBranchCode() {
        return branchCode;
    }

    public void setBranchCode(String branchCode) {
        this.branchCode = branchCode;
    }

    /**
     * Get text between two strings. Passed limiting strings are not
     * included into result.
     *
     * @param text     Text to search in.
     * @param textFrom Text to start cutting from (exclusive).
     * @param textTo   Text to stop cutting at (exclusive).
     */
    public static String getBetweenStrings(String text, String textFrom, String textTo) {

        String result = "";

        // Cut the beginning of the text to not occasionally meet a
        // 'textTo' value in it:
        result = text.substring(text.indexOf(textFrom) + textFrom.length(), text.length());

        // Cut the excessive ending of the text:
        result = result.substring(0, result.indexOf(textTo));

        return result;
    }

    public static String convertDateFormat(String dateTobeConvert) {
        String formattedDate = null;
        try {
            Date date;
            DateFormat originalFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
            DateFormat targetFormat = new SimpleDateFormat("MM/dd/yy", Locale.ENGLISH);
            date = originalFormat.parse(dateTobeConvert);
            formattedDate = targetFormat.format(date);
            Logger.v("Converted Date: "+formattedDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return formattedDate;
    }


}
