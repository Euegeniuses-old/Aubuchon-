//
//  MainViewController.swift
//  Aubuchon
//
//  Created by mac on 13/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class MainViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var lblCaptureImage: UILabel!
    @IBOutlet weak var lblOR: UILabel!
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCamera: UIButton!
    //@IBOutlet weak var imageTake: UIImageView!
    
    //variables
    var imagePicker: UIImagePickerController!
    var isOnLoad:Bool = true
    var barCodeNumber:String = ""
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblCaptureImage.textColor = Constant.Colors.textColor
        lblOR.textColor = Constant.Colors.textColor
        txtCode.textColor = Constant.Colors.textColor
        txtCode.layer.borderWidth = 1
        txtCode.layer.cornerRadius = 5
        txtCode.layer.borderColor = Constant.Colors.textColor.cgColor
        btnOk.backgroundColor =  UIColor(red: 15/255, green: 109/255, blue: 166/255, alpha: 1.0)
        // btnOk.setTitleColor(Constant.Colors.textColor, for: UIControlState.normal)
        // Tabgesture of lblCaptureImage
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureOpenCameraRecognizer(tapGestureRecognizer:)))
        self.lblCaptureImage.isUserInteractionEnabled = true
        self.lblCaptureImage.addGestureRecognizer(tapGestureRecognizer)
        
        btnCamera.isEnabled = true
        lblCaptureImage.isUserInteractionEnabled = true
        isOnLoad = true
        publicAPICall()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtCode.text = barCodeNumber
         btnCamera.isEnabled = true
        lblCaptureImage.isUserInteractionEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- publicAPI call
    func publicAPICall() {
        
        let url = URL(string: "https://api.ipify.org/")
        var ipAddress: String? = nil
        if let anUrl = url {
            ipAddress = try? String(contentsOf: anUrl, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        }
        ImageUpload.checkpublicIp(with: ipAddress ?? "", success: { (response, isSuccess) in
            if !isSuccess {
                let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    // exit(0);
                    UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                           to: UIApplication.shared, for: nil)
                }))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                if !self.isOnLoad {
                    self.openMTBScanner()
                    //Swift sacn library used
                    //self.showScannerNewUI()
                    //                    self.openCamera()
                }
                
            }
            
        }) { (response, isSuccess) in
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    // exit(0);
                    UIControl().sendAction(#selector(NSXPCConnection.suspend),
                                           to: UIApplication.shared, for: nil)
                    
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //MARK:- Private functions
    
    //Label gesture recognizer
    @objc func tapGestureOpenCameraRecognizer(tapGestureRecognizer: UITapGestureRecognizer) {
        lblCaptureImage.isUserInteractionEnabled = false
        btnCamera.isEnabled = false
        isOnLoad = false
        publicAPICall()
    }
    //Open camera
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            self.alertMessage(message: Constant.alertTitleMessage.cameranotfoundAlertMessage, title: Constant.alertTitleMessage.cameranotfoundTitleMessage)
        }
    }
    
    // Open  MTBScanner
    func openMTBScanner() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScannerView") as! ScannerViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
   
    //MARK:- Button action
    
    //Capture button action
    @IBAction func btnCaptureImage_Action(_ sender: Any) {
         btnCamera.isEnabled = false
        lblCaptureImage.isUserInteractionEnabled = false
        isOnLoad = false
        publicAPICall()
    }
    
    @IBAction func btnOk_Action(_ sender: Any) {
        txtCode.text = ""
    }
}

//MARK:-  Image picker extention
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        //Save image in to gallery
        UIImageWriteToSavedPhotosAlbum((info[UIImagePickerControllerEditedImage] as? UIImage)!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        //Move on upload image screen with captured image
        let  UploadImageVC:
            UploadImageViewController = UIStoryboard(
                name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "uploadImage") as! UploadImageViewController
        UploadImageVC.imgCapturedImage  = info[UIImagePickerControllerEditedImage] as? UIImage
        self.present(UploadImageVC, animated: false, completion: nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
    }
}

