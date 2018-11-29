package com.aubuchon.apis;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;

import com.aubuchon.R;


public class ConnectionDetector {

    public static boolean isConnectingToInternet(Activity context) {
        ConnectivityManager connectivityManager
                = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo activeNetworkInfo = null;
        if (connectivityManager != null) {
            activeNetworkInfo = connectivityManager.getActiveNetworkInfo();
        }
        return activeNetworkInfo != null && activeNetworkInfo.isAvailable() && activeNetworkInfo.isConnected();
    }

    public static boolean internetCheck(Activity context, boolean showDialog) {
        if (isConnectingToInternet(context))
            return true;
        if (showDialog) {
            showAlertDialog(context, context.getString(R.string.msg_NO_INTERNET_TITLE), context.getString(R.string.msg_NO_INTERNET_MSG), false);
        }
        return false;
    }

    public static void showAlertDialog(final Activity context, String pTitle, final String pMsg, Boolean status) {
        try {
            AlertDialog.Builder builder = new AlertDialog.Builder(context);

            builder.setTitle(pTitle);
            builder.setMessage(pMsg);
            builder.setCancelable(false);
            builder.setPositiveButton(context.getString(android.R.string.ok),
                    new DialogInterface.OnClickListener() {
                        @Override
                        public void onClick(DialogInterface dialog, int which) {
                            dialog.dismiss();
                            context.finish();
                          /*  Intent intent = new Intent(Settings.ACTION_WIRELESS_SETTINGS);
                            context.startActivity(intent);*/

                        }
                    });
            AlertDialog alert = builder.create();
            alert.show();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
