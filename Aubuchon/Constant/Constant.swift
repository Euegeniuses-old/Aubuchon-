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

typealias FailureBlock = (_ error: String,_ customError: ErrorType) -> Void

//Error enum

enum ErrorType: String {
    case server = "Error"
    case connection = "No connection"
    case response = ""
}
class Constant: NSObject {
    
    struct APIURLANDKEY {
        //local
        //static let baseUrl = "http://differenzuat.com/AubuChon/aubuchonapi"
        //static let baseUrl = "https://differenzuat.com/aubuchon/aubuchonapi"
        
        //live
        static let baseUrl = "http://aubuchonapp.a.fgqa.net/AubuChonApi"
        static let uploadImageApi = baseUrl + "/api/Home/Upload"
    }
    struct Colors {
        //static let textColor =   UIColor(red: 15/255, green: 109/255, blue: 166/255, alpha: 1.0)
        static let textColor = hexStringToUIColor(hex: "#0F6DA6")
    }
    
    struct alertTitleMessage {
        static let comingsoonAlertMessage = "Coming Soon..."
        static let cameranotfoundTitleMessage = "Camera Not Found"
        static let cameranotfoundAlertMessage = "This device has no Camera"
        static let internetNotAvailable = "Check your internet connection"
        static let uploadImageSuccessfully = "Image uploaded sucessfully"
    }
    
}
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
