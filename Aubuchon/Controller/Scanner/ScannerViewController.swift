//
//  ScannerViewController.swift
//  Aubuchon
//
//  Created by mac on 04/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
import MTBBarcodeScanner

class ScannerViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var btnRescan: UIButton!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet var scannerPreview: UIView!
    @IBOutlet weak var scannerView: UIView!
    @IBOutlet weak var barcodeImage: UIImageView!
    
    //Variables
    var scanner: MTBBarcodeScanner?
    var mainViewScanner: MTBBarcodeScanner?
    var isCaptureIsFrozen = false
    var tempCaptureString = ""
    
    //MARK:- Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRescan.backgroundColor = Constant.Colors.textColor
        btnOk.backgroundColor = Constant.Colors.textColor
        btnRescan.layer.borderWidth = 1
        btnRescan.layer.borderColor = UIColor.white.cgColor
        btnOk.layer.borderWidth = 1
        btnOk.layer.borderColor = UIColor.white.cgColor
        scanner = MTBBarcodeScanner(previewView: scannerPreview)

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startScanning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.scanner?.stopScanning()
    }
    
    //MARK:- Private functions
   
    func capturedProcess() {
        showMsg(title: nil, message: tempCaptureString)
        
        self.isCaptureIsFrozen = !self.isCaptureIsFrozen
    }
    
    // stop scanning
    func stopScanning() {
        scanner?.stopScanning()
        isCaptureIsFrozen = false
    }
    
    // start scanning
    func startScanning() {
        let error: Error? = nil
        
        try? scanner?.startScanning(resultBlock: {(_ codes: [AVMetadataMachineReadableCodeObject]?) -> Void in
            
            for code: AVMetadataMachineReadableCodeObject in codes! {
                if (code.stringValue != nil){
                    self.scanner?.freezeCapture()
                    self.isCaptureIsFrozen = true
                   
                    if let codes = codes {
                        print(codes.count)
                        for code in codes {
                            let stringValue = code.stringValue!
                            print("Found code: \(stringValue)")
                            self.tempCaptureString = stringValue
                            self.capturedProcess()
                        }
                    }
                } else {
                    print("Code not found")
                }
            }
        })
        
        if error != nil {
            print("An error occurred: \(String(describing: error?.localizedDescription))")
        }
    }
    
    // barcode display in alert
    func showMsg(title: String?, message: String?) {
        
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertActionStyle.default) { (alertAction) in
            // self.barcodeNumber = message!
        }
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Button actions
    
    // btnrescan action
    @IBAction func btnRescan_Action(_ sender: Any) {
        self.scanner?.unfreezeCapture()
    }
    
    // btnok action
    @IBAction func btnOk_Action(_ sender: Any) {
        if tempCaptureString != "" {
            let viewController:
                MainViewController = UIStoryboard(
                    name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "Main") as! MainViewController
            viewController.barCodeNumber = tempCaptureString
            let NavigationController = UINavigationController(rootViewController: viewController)
            UIApplication.shared.keyWindow?.rootViewController? = NavigationController
        }
    }
}
