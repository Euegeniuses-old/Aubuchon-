package com.developer.weatcb;

import android.Manifest;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.AppCompatEditText;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.LinearLayout;

import com.developer.R;
import com.developer.weatcb.apis.GetCall;
import com.developer.weatcb.apis.GetCall.OnGetServiceCallListener;
import com.developer.weatcb.scanner.ItemDetailFragment;
import com.developer.weatcb.scanner.ScannerActivity;
import com.developer.weatcb.utility.Constant;
import com.developer.weatcb.utility.Globals;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.gun0912.tedpermission.PermissionListener;
import com.gun0912.tedpermission.TedPermission;
import com.orhanobut.logger.Logger;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class HomeFragment extends Fragment {

    public static final int SCAN_BARCODE_REQUEST = 1001;

    @BindView(R.id.ll_camera)
    LinearLayout ll_camera;
    @BindView(R.id.et_code)
    public AppCompatEditText et_code;

    NavigationActivity mContext;
    public String scannedCode = "";
    boolean isFromCameraClick = false;
    boolean isFromButtonClick = false;

    Globals globals;

    public static HomeFragment newInstance() {
        return new HomeFragment();
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        try {
            mContext = (NavigationActivity) context;
        } catch (ClassCastException e) {
            e.printStackTrace();
        }
    }

    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.activity_main, container, false);
        ButterKnife.bind(this, view);
        globals = (Globals) mContext.getApplicationContext();
        return view;
    }

    @Override
    public void onViewCreated(@NonNull View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        isFromCameraClick = false;
        isFromButtonClick = false;

        if (!globals.barCode.isEmpty()) {
            et_code.setText(globals.barCode);
            globals.barCode = "";
        }


        mContext.setToolbar();
        doRequestForGetPublicIP();
    }

    @OnClick({R.id.ll_camera})
    public void getPermissionForCamera() {
        isFromCameraClick = true;
        doRequestForGetPublicIP();
    }


    @OnClick(R.id.btn_ok)
    public void btnOkClick() {
        isFromButtonClick = true;
        doRequestForGetPublicIP();
    }

    private void doRequestForGetProductDetail() {
        if (!et_code.getText().toString().isEmpty()) {

            mContext.isFromTitle = false;
            globals.passCode = et_code.getText().toString().trim();
            et_code.setText("");
            if (getActivity() != null) {
                globals.isFromMenu = false;
                mContext.setToolbar();
                mContext.addFragmentOnTop(ItemDetailFragment.newInstance(globals.passCode));
                globals.passCode = "";
                globals.barCode = "";
            }
        } else {
            Globals.showToast(mContext, getString(R.string.msg_enter_barcode));
        }
    }

    private void doRequestForGetPublicIP() {
        String url = mContext.getString(R.string.url_white_listed_ip);
        new GetCall(mContext, url, new JSONObject(), new OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {
                if (response.has(Constant.AU_ip)) {
                    try {
                        doRequestForCheckPublicIP(response.getString(Constant.AU_ip));
                    } catch (JSONException e) {
                        e.printStackTrace();
                    }
                }
            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(mContext, getString(R.string.msg_server_error));
            }
        }, true).doRequest();
    }

    private void doRequestForCheckPublicIP(final String publicIp) {

        String url = mContext.getString(R.string.url_ip_white_list);

        new GetCall(mContext, url, new JSONObject(), new OnGetServiceCallListener() {
            @Override
            public void onSucceedToGetCall(JSONObject response) {

                HashMap<String, String> ipAddressMaps;
                ipAddressMaps = new Gson().fromJson(response.toString(), new TypeToken<HashMap<String, String>>() {
                }.getType());

                if (!ipAddressMaps.containsKey(publicIp)) {
                    AlertDialog.Builder builder = new AlertDialog.Builder(mContext)
                            .setMessage(R.string.msg_ip_not_whitelisted)
                            .setCancelable(false)
                            .setPositiveButton(getString(android.R.string.ok), new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    ExitActivity.exitApplication(mContext);
                                }
                            });
                    AlertDialog alert = builder.create();
                    alert.show();

                } else {


                    String ipData = ipAddressMaps.get(publicIp);

                    /*String ipData = ipAddressMaps.get("71.234.185.184");*/

                    if (ipData != null) {
                        if (ipData.contains("aub-") && ipData.contains(".")) {
                            String branchCode = Globals.getBetweenStrings(ipData, "aub-", ".");
                            globals.setBranchCode(branchCode);
                            Logger.i("BranchCode: " + branchCode);
                        } else {
                            globals.setBranchCode(Constant.AU_Branch_Code);
                        }
                    } else {
                        globals.setBranchCode(Constant.AU_Branch_Code);
                    }


                    if (isFromCameraClick) {
                        PermissionListener permissionlistener = new PermissionListener() {
                            @Override
                            public void onPermissionGranted() {
                                Intent intent = new Intent(mContext, ScannerActivity.class);
                                startActivityForResult(intent, SCAN_BARCODE_REQUEST);
                            }

                            @Override
                            public void onPermissionDenied(ArrayList<String> deniedPermissions) {
                                Globals.showToast(mContext, getString(R.string.permission_denied) + deniedPermissions.toString());
                            }
                        };

                        TedPermission.with(mContext)
                                .setPermissionListener(permissionlistener)
                                .setDeniedMessage(getString(R.string.on_denied_permission))
                                .setGotoSettingButtonText(getString(R.string.setting))
                                .setPermissions(Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                                .check();
                    }

                    if (mContext.isFromTitle) {
                        et_code.post(new Runnable() {
                            @Override
                            public void run() {
                                et_code.requestFocus();
                                InputMethodManager imgr = (InputMethodManager) mContext.getSystemService(Context.INPUT_METHOD_SERVICE);
                                imgr.showSoftInput(et_code, InputMethodManager.SHOW_IMPLICIT);
                            }
                        });

                    } else {
                        Globals.hideKeyboard(mContext);
                    }

                    if (isFromButtonClick) {
                        doRequestForGetProductDetail();
                    }

                }
            }

            @Override
            public void onFailedToGetCall() {
                Globals.showToast(mContext, mContext.getString(R.string.msg_ip_not_whitelisted));
            }
        }, true).doRequest();

    }

    // Handle Result come from Scanning(Camera Image)
    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == SCAN_BARCODE_REQUEST && data != null) {
            scannedCode = data.getExtras().getString(Constant.AU_Data);
            et_code.setText(scannedCode);
            /*Handle a flow to redirect on detail screen After done scan from Camera Image */
            doRequestForGetProductDetail();
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mContext = null;
    }

}
