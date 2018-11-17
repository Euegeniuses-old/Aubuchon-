//
//  UploadImageViewController.swift
//  Aubuchon
//
//  Created by mac on 13/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class UploadImageViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var btnRescan: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var imgcapture: UIImageView!
    
    //Variables
    var imgCapturedImage: UIImage!
    var imagePicker: UIImagePickerController!
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgcapture.image = imgCapturedImage
        btnRescan.setTitleColor(Constant.Colors.textColor, for: UIControlState.normal)
        btnUpload.setTitleColor(Constant.Colors.textColor, for: UIControlState.normal)
    }
    
    //MARK:- Button actions
    
    //Rescan button action
    @IBAction func btnRescan_Action(_ sender: Any) {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            //            present(imagePicker, animated: true, completion: nil)
            present(imagePicker, animated: true) {
                
            }
        } else {
            self.alertMessage(message: Constant.alertTitleMessage.cameranotfoundAlertMessage, title: Constant.alertTitleMessage.cameranotfoundTitleMessage)
        }
    }
    //Upload button action
    @IBAction func btnUpload_Action(_ sender: Any) {
        //self.alertMessage(message: Constant.alertTitleMessage.comingsoonAlertMessage, title: "")
        if  APIManager.isConnectedToNetwork() {
            imageUplaodAPI()
        } else {
            self.alertMessage(message: Constant.alertTitleMessage.internetNotAvailable, title: "")
        }
    }
    
    // MARK:- Image upload API call
    func imageUplaodAPI() {
        ImageUpload.uploadImageData(with: imgcapture.image, success: { (response) in
            // print(response)
            let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                self.dismiss(animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
        }) { (_, error) in
            print(error)
        }
    }
}

//MARK:-  Image picker extention
extension UploadImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        imgcapture.image = info[UIImagePickerControllerEditedImage] as? UIImage
        UIImageWriteToSavedPhotosAlbum(imgcapture.image!, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
