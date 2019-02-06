//
//  Constant.swift
//  Aubuchon
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

typealias FailureBlock = (_ error: String,_ customError: Bool) -> Void

//Error enum

enum ErrorType: String {
    case server = "Error"
    case connection = "No connection"
    case response = ""
}
enum UserDefaultsKeys : String {
    case kskuCurrent
    case kskuOld
}
class Constant: NSObject {
    
    struct APIURLANDKEY {
        //UAT
        //static let baseUrl = "http://differenzuat.com/AubuChon/aubuchonapi"
        // static let baseUrl = "https://differenzuat.com/aubuchon/aubuchonapi"
        
        //live
        static let baseUrl = "http://aubuchonapp.a.fgqa.net/AubuChonApi"
        static let uploadImageApi = baseUrl + "/api/Home/Upload"
        static let publicIp = baseUrl + "/api/Home/CheckPublicIp"
        static let fetchBranchCode = "http://www.aubuchon.com/proxy/dyndns-json.pl"
        
        //Temporary
        //static let productInfo = "http://50.206.125.135/webservice/GetProductStore.aspx"
        //11_1_19 12:49 pm
        
        //Old
        //static let productInfo = "http://50.206.125.135/WebService/getproductTCB.aspx"
        
        //New
        //EDITED:- 22-jan-2019 (changes in product info base URL) parth
        static let productInfo = "http://50.206.125.135/webservice/getTCBproduct.aspx"
        static let kGetSalesHistory = "http://50.206.125.135/webservice/getTCBsalesCombined.aspx"
        static let kGetLocalINV = "http://50.206.125.135/webservice/getTCBinventory.aspx"
        static let kGetReletedProduct = "http://50.206.125.135/webservice/getTCBrelated.aspx"
    }
    
    // Colors type
    struct Colors {
        //static let textColor =   UIColor(red: 15/255, green: 109/255, blue: 166/255, alpha: 1.0)
        static let textColor = hexStringToUIColor(hex: "#0F6DA6")
        static let color_gray = hexStringToUIColor(hex: "#CCCCCC")
        
       
    }
    
    // alert messages
    struct alertTitleMessage {
        static let comingsoonAlertMessage = "Coming Soon..."
        static let cameranotfoundTitleMessage = "Camera Not Found"
        static let cameranotfoundAlertMessage = "This device has no Camera"
        static let internetNotAvailable = "Check your internet connection"
        static let uploadImageSuccessfully = "Image uploaded sucessfully"
        static let barcodeAlert = "Enter barcode"
        static let validBarcode = "Enter valid barcode number"
        static let someThingWentWrong = "Something went wrong. Try again later"
    }
    
    // productKeys
    struct projectKeys {
        static let kskuCurrent = "skuCurrent"
        static let kskuOld = "skuOld"
    }
    
    //screen size
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    //iPhone devicetype
    struct DeviceType {
        static let iOS                  = "2"
        static let IS_IPHONE_4_OR_LESS  = ScreenSize.SCREEN_MAX_LENGTH < 568.0
        static let IS_IPHONE_5          = ScreenSize.SCREEN_MAX_LENGTH == 568.0
        static let IS_IPHONE_6          = ScreenSize.SCREEN_MAX_LENGTH == 667.0
        static let IS_IPHONE_6P         = ScreenSize.SCREEN_MAX_LENGTH == 736.0
        static let IS_IPHONE_X          = ScreenSize.SCREEN_HEIGHT == 812.0
        static let IS_PAD               = UIDevice.current.userInterfaceIdiom == .pad
        static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
        static let IS_IPAD_PRO          = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    }
    struct UserDefaultsKey {
        static let kProductInfo                    = "isProductInfo"
    }
    // MARK: - Appdelegate variable initilize key
   static let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
}

//MARK:- color hexa value convert to color
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

//store value in userdefault
extension UserDefaults {
    
    //MARK: Save Current SKU Data
    func setCurrentSKU(value: String) {
        set(value, forKey: UserDefaultsKeys.kskuCurrent.rawValue)
        //synchronize()
    }
    //MARK: Save Old SKU Data
    func setOldSKU(value: String) {
        set(value, forKey: UserDefaultsKeys.kskuOld.rawValue)
        //synchronize()
    }
    
    //MARK: Retrieve Current SKU Data
    
    func getCurrentSKU() -> String {
        return string(forKey: UserDefaultsKeys.kskuCurrent.rawValue) ?? "0123456"
    }
    
    func getOldSKU() -> String {
        return string(forKey: UserDefaultsKeys.kskuOld.rawValue) ?? "012345"
    }
    
    
    func contains(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    class var productData: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constant.UserDefaultsKey.kProductInfo)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constant.UserDefaultsKey.kProductInfo)
        }
    }
}
