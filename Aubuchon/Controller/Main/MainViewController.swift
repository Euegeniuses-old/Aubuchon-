//
//  MainViewController.swift
//  Aubuchon
//
//  Created by mac on 13/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var lblCaptureImage: UILabel!
    //@IBOutlet weak var imageTake: UIImageView!
    
    //variables
    var imagePicker: UIImagePickerController!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        lblCaptureImage.textColor = Constant.Colors.textColor
        
        // Tabgesture of lblCaptureImage
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureOpenCameraRecognizer(tapGestureRecognizer:)))
        self.lblCaptureImage.isUserInteractionEnabled = true
        self.lblCaptureImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        //        print("My public IP address is: \(ipAddress ?? "")")
        ImageUpload.checkpublicIp(with: ipAddress ?? "", success: { (response, isSuccess) in
            if !isSuccess {
                let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    exit(0);
                }))
                
                self.present(alert, animated: true, completion: nil)
            } else {
                self.openCamera()
            }
            
        }) { (response, isSuccess) in
            
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                    exit(0);
                }))
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    
    
    //MARK:- Private functions
    
    //Label gesture recognizer
    @objc func tapGestureOpenCameraRecognizer(tapGestureRecognizer: UITapGestureRecognizer) {
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
    
    //MARK:- Button action
    
    //Capture button action
    @IBAction func btnCaptureImage_Action(_ sender: Any) {
        publicAPICall()
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

