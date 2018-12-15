package com.aubuchon;

import android.Manifest;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v7.app.AlertDialog;
import android.support.v7.app.AlertDialog.Builder;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.AppCompatEditText;
import android.support.v7.widget.AppCompatImageView;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.aubuchon.apis.GetCall;
import com.aubuchon.apis.GetCall.OnGetServiceCallListener;
import com.aubuchon.apis.HttpRequestHandler;
import com.aubuchon.apis.PostRequest;
import com.aubuchon.apis.PostRequest.OnPostServiceCallListener;
import com.aubuchon.apis.PostWithRequestParam;
import com.aubuchon.scanner.ItemDetailActivity;
import com.aubuchon.scanner.ScannerActivity;
import com.aubuchon.utility.Constant;
import com.aubuchon.utility.Globals;
import com.gun0912.tedpermission.PermissionListener;
import com.gun0912.tedpermission.TedPermission;
import com.loopj.android.http.RequestParams;

import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import pl.aprilapps.easyphotopicker.DefaultCallback;
import pl.aprilapps.easyphotopicker.EasyImage;

public class MainActivity extends AppCompatActivity {

    @BindView(R.id.ll_camera)
    LinearLayout ll_camera;
    @BindView(R.id.ll_captured_image)
    LinearLayout ll_captured_image;
    @BindView(R.id.iv_selected_image)
    AppCompatImageView iv_selected_image;
    @BindView(R.id.et_code)
    AppCompatEditText et_code;

    File selectedImage;
    boolean isFromCameraClick = false;
    Globals globals;

    public static final int SCAN_BARCODE_REQUEST = 1001;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);
        globals = (Globals) getApplicationContext();
        isFromCameraClick = false;
        doRequestForGetPublicIP();
    }

    @OnClick({R.id.ll_camera, R.id.btn_rescan})
    public void getPermissionForCamera() {
        isFromCameraClick = true;
        doRequestForGetPublicIP();
    }


    @OnClick(R.id.btn_Upload)
    public void uploadImage() {
        //  Toast.makeText(this, "Coming Soon...", Toast.LENGTH_SHORT).show();
        doRequestForUploadImage();

    }

    @OnClick(R.id.btn_ok)
    public void doRequestForGetProductDetail() {
        // et_code.setText("");
        if (!et_code.getText().toString().isEmpty()) {
            Intent intent = new Intent(MainActivity.this, ItemDetailActivity.class);
            intent.putExtra(Constant.AU_data, et_code.getText().toString().trim());
            startActivity(intent);
        }
    }

    public void doRequestForGetPublicIP() {
        String url = "https://api.ipify.org/?format=json";
        new GetCall(MainActivity.this, url, new JSONObject(), new OnGetServiceCallListener() {
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
                Globals.showToast(MainActivity.this, getString(R.string.msg_server_error));
            }
        }, true).doRequest();
    }

    public void doRequestForCheckPublicIP(String publicIP) {
        String url = getString(R.string.server_url) + getString(R.string.checkPublicIp_url);
        JSONObject param = HttpRequestHandler.getInstance().getCheckPublicIpParams(publicIP);

        new PostRequest(MainActivity.this, url, param, true, new OnPostServiceCallListener() {
            @Override
            public void onSucceedToPostCall(JSONObject response) {
                try {
                    if (!response.getBoolean(Constant.AU_IsSuccess)) {
                        AlertDialog.Builder builder = new Builder(MainActivity.this).setMessage(response.getString(Constant.AU_Message)).setCancelable(false).setPositiveButton(getString(android.R.string.ok), new OnClickListener() {
                            @Override
                            public void onClick(DialogInterface dialogInterface, int i) {
                                ExitActivity.exitApplication(getApplicationContext());
                            }
                        });
                        AlertDialog alert = builder.create();
                        alert.show();
                    } else {
                        if (isFromCameraClick) {
                            PermissionListener permissionlistener = new PermissionListener() {
                                @Override
                                public void onPermissionGranted() {
                                    // EasyImage.openCamera(MainActivity.this, 0);
                                    Intent intent = new Intent(MainActivity.this, ScannerActivity.class);
                                    startActivityForResult(intent, SCAN_BARCODE_REQUEST);

                                }

                                @Override
                                public void onPermissionDenied(ArrayList<String> deniedPermissions) {
                                    Toast.makeText(MainActivity.this, getString(R.string.permission_denied) + deniedPermissions.toString(), Toast.LENGTH_SHORT).show();
                                }
                            };

                            TedPermission.with(MainActivity.this)
                                    .setPermissionListener(permissionlistener)
                                    //.setRationaleMessage(getString(R.string.request_camera_permission))
                                    .setDeniedMessage(getString(R.string.on_denied_permission))
                                    .setGotoSettingButtonText(getString(R.string.setting))
                                    .setPermissions(Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                                    .check();
                        }
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onFailedToPostCall(int statusCode, String msg) {
                Globals.showToast(MainActivity.this, msg);
            }
        }).execute();
    }

    public void doRequestForUploadImage() {

        String url = getString(R.string.server_url) + getString(R.string.upload_url);

        RequestParams param = HttpRequestHandler.getInstance().getUploadImageParams(selectedImage);

        new PostWithRequestParam(MainActivity.this, url, param, true, new PostWithRequestParam.OnPostWithReqParamServiceCallListener() {
            @Override
            public void onSucceedToPostCall(JSONObject response) {

                try {
                    Globals.showToast(MainActivity.this, response.getString(Constant.AU_Message));
                    if (response.getBoolean(Constant.AU_IsSuccess)) {
                        ll_captured_image.setVisibility(View.GONE);
                        ll_camera.setVisibility(View.VISIBLE);
                        selectedImage = null;
                    }
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onFailedToPostCall(int statusCode, String msg) {
                Globals.showToast(MainActivity.this, msg);
            }
        }).execute();
    }

    private void onPhotoReturned(File photoFile) {
        selectedImage = photoFile;
        ll_camera.setVisibility(View.GONE);
        ll_captured_image.setVisibility(View.VISIBLE);

      /*  GlideApp.with(MainActivity.this)
                .load(photoFile)
                .centerCrop()
                .into(iv_selected_image);*/
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);

        if (requestCode == SCAN_BARCODE_REQUEST && resultCode == RESULT_OK) {
            et_code.setText(data.getStringExtra(Constant.AU_Data));
            et_code.setSelection(et_code.getText().toString().trim().length());
        } else {
            EasyImage.handleActivityResult(requestCode, resultCode, data, MainActivity.this, new DefaultCallback() {
                @Override
                public void onImagePickerError(Exception e, EasyImage.ImageSource source, int type) {
                    //Some error handling
                }

                @Override
                public void onImagesPicked(@NonNull List<File> imageFiles, EasyImage.ImageSource source, int type) {
                    if (!imageFiles.isEmpty()) onPhotoReturned(new File(imageFiles.get(0).toURI()));
                }

                @Override
                public void onCanceled(EasyImage.ImageSource source, int type) {
                    //Cancel handling, you might wanna remove taken photo if it was canceled
                    if (source == EasyImage.ImageSource.CAMERA) {
                        File photoFile = EasyImage.lastlyTakenButCanceledPhoto(MainActivity.this);
                        if (photoFile != null) photoFile.delete();
                    }
                }
            });
        }
    }
}
