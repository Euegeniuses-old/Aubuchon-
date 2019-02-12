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
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tblMenu: UITableView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    //@IBOutlet weak var imageTake: UIImageView!
    
    //variables
    var ipAddress: String? = nil
    var imagePicker : UIImagePickerController!
    var isOnLoad : Bool = true
    var barCodeNumber : String = ""
    var menu : [String] = ["Home","Product Info"]
    var isMenuVisible = false
    var isOk:Bool = false
    var isFromSKUClick:Bool = false
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIConfig()
        publicAPICall()
        hideMenuView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Constant.kAppDelegate.isBackFromProduct != true {
            txtCode.text = Constant.kAppDelegate.barcodeNumber
            barCodeNumber = Constant.kAppDelegate.barcodeNumber
        } else {
            txtCode.text = ""
            barCodeNumber = ""
        }
        if barCodeNumber != "" {
            lblSKU.text = "SKU:\(barCodeNumber)"
        } else {
            lblSKU.text = ""
        }
        btnCamera.isEnabled = true
        lblCaptureImage.isUserInteractionEnabled = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK:- publicAPI call
    func publicAPICall() {
       
        let url = URL(string: "https://api.ipify.org/")
        
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
                self.getBranchCode()
                if !self.isOnLoad {
                    self.openMTBScanner()
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
    
    //MARK:- get branchcode api call
    func getBranchCode() {
        ImageUpload.callBrachcodeAPI(success: { (branchCodeResponse) in
         
            branchCodeResponse.contains(where: { (ipAddressData) -> Bool in
                if ipAddressData.key == self.ipAddress {
                    
                    let ipValue:String = ipAddressData.value as! String
                    //                    let fetchedBrachCode = ipValue.subStr(s: 4, l: 3)
                    //                    let branchCodeData = fetchedBrachCode.subStr(s: 0, l: 1)
                    //                    singaltan.aubuchon.branchCode = branchCodeData.isValidNumericString() ? fetchedBrachCode : "049"
                    
                    if ipValue.contains("aub-") && ipValue.contains(".") {
                        
                        let fetchedBrachCode =  ipValue.slice(from: "aub-", to: ".")
                        singaltan.aubuchon.branchCode = (fetchedBrachCode?.isValidNumericString())! ? fetchedBrachCode ?? "049" : "049"
                        
                    } else {
                        singaltan.aubuchon.branchCode = "049"
                    }
                    if self.isOk {
                        var textdata = self.txtCode.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                        if textdata != "" {
                            
                            //  UserDefaults.standard.setCurrentSKU(value: (txtCode.text?.trim())!)
                            Constant.kAppDelegate.isOldProductData = false
                            let  secondViewController:
                                ProductInformationViewController = UIStoryboard(
                                    name: "Main", bundle: nil
                                    ).instantiateViewController(withIdentifier: "ProductInfo") as! ProductInformationViewController
                            secondViewController.barcode = self.txtCode.text ?? "1"
                            
                            self.present(secondViewController, animated: false, completion: nil)
                        } else {
                            self.alertMessage(message: Constant.alertTitleMessage.barcodeAlert, title: "")
                        }
                    }
                    return true
                } else {
                    
                    return false
                }
                
            })
        }, failure: { (error, isSuccess) in
            self.alertMessage(message: error, title: "")
        })
    }
    
    //MARK:- Private functions
    
    // UIConfiguration
    func UIConfig() {
        // Do any additional setup after loading the view.
        lblCaptureImage.textColor = UIColor.black
      
        txtCode.textColor = UIColor.black
        
        // btnOk.setTitleColor(Constant.Colors.textColor, for: UIControlState.normal)
        menuView.layer.borderColor = UIColor.black.cgColor
        menuView.layer.borderWidth = 1
        
        btnCamera.isEnabled = true
        lblCaptureImage.isUserInteractionEnabled = true
        isOnLoad = true
        isOk = false
        
        // Tabgesture of lblCaptureImage
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureOpenCameraRecognizer(tapGestureRecognizer:)))
        self.lblCaptureImage.isUserInteractionEnabled = true
        self.lblCaptureImage.addGestureRecognizer(tapGestureRecognizer)
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollViewTap.numberOfTapsRequired = 1
        scrollView.addGestureRecognizer(scrollViewTap)
        
        // menu cell xib register
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.isToolbarHidden = true
        
        if isFromSKUClick {
            self.txtCode.becomeFirstResponder()
        }
    }
    
    @objc func scrollViewTapped() {
       hideMenuView()
    }
    
    //Label gesture recognizer
    @objc func tapGestureOpenCameraRecognizer(tapGestureRecognizer: UITapGestureRecognizer) {
        lblCaptureImage.isUserInteractionEnabled = false
        btnCamera.isEnabled = false
        isOnLoad = false
        isOk = false
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
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let  ScannerVC:
                ScannerViewController = UIStoryboard(
                    name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "ScannerView") as! ScannerViewController
            ScannerVC.isFromMain = true
            self.present(ScannerVC, animated: false, completion: nil)
        } else {
            self.alertMessage(message: Constant.alertTitleMessage.cameranotfoundAlertMessage, title: Constant.alertTitleMessage.cameranotfoundTitleMessage)
        }
        
    }
    
    //show menu
    func showAndHideFilterMenu() {
        if isMenuVisible == false {
            self.menuView.alpha = 0.0
            self.menuView.isHidden = false
            self.isMenuVisible = true
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
                self.menuView.alpha = 1.0
            }) { (isCompleted) in
            }
        } else {
            hideMenuView()
        }
    }
    
    // hide menu
    private func hideMenuView() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            self.menuView.alpha = 0.0
        }) { (isCompleted) in
            self.menuView.isHidden = true
            self.self.isMenuVisible = false
        }
    }
    
    //touchebegan function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.view == self.mainView  || touch?.view == self.headerView {
            hideMenuView()
        }
    }
    
    // MARK:  Menu item selection
    fileprivate func menuItemSelected(Row num: Int) {
        hideMenuView()
        switch num {
        case 0:
            print("Home")
        case 1:
            print("Profile Info")
            
            if  UserDefaults.standard.getCurrentSKU() != "" {
                Constant.kAppDelegate.isOldProductData = true
                let  secondViewController:
                    ProductInformationViewController = UIStoryboard(
                        name: "Main", bundle: nil
                        ).instantiateViewController(withIdentifier: "ProductInfo") as! ProductInformationViewController
                secondViewController.barcode = UserDefaults.standard.getCurrentSKU()
                self.present(secondViewController, animated: false, completion: nil)
            }
            
        default:
            print("Default menu")
        }
    }
    
    //MARK:- Button action
    
    // btnMenu action
    @IBAction func btnMenu_Action(_ sender: Any) {
        showAndHideFilterMenu()
    }
    
    //Capture button action
    @IBAction func btnCaptureImage_Action(_ sender: Any) {
        btnCamera.isEnabled = false
        lblCaptureImage.isUserInteractionEnabled = false
        isOnLoad = false
        isOk = false
        publicAPICall()
    }
    
    //btnOk button
    @IBAction func btnOk_Action(_ sender: Any) {
        //txtCode.text = ""
        publicAPICall()
        isOnLoad = true
        isOk = true
//        DispatchQueue.main.async {
//
//        }
        hideMenuView()
    }
    @IBAction func btnBarcode_Action(_ sender: Any) {
        Constant.kAppDelegate.isOldProductData = false
        publicAPICall()
        isOnLoad = false
        isOk = false
        //self.openMTBScanner()
        
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

// MARK:- table methods
extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblMenu.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.lblMenu.text = menu[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblMenu {
            //tblMenu.backgroundColor = UIColor.blue
            menuItemSelected(Row: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

