//
//  APIManager.swift
//  Aubuchon
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration
import Alamofire

class APIManager {
    
    //MARK:- Internet connection check
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    
    class func makeRequest(with url: String, method: HTTPMethod, parameter: [String:Any]?, success: @escaping (_ response: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void) {
        
        if(isConnectedToNetwork()) {
            print(method.rawValue, url)
            if let param = parameter, let data = try? JSONSerialization.data(withJSONObject: param, options: .prettyPrinted) {
                print(String(data: data, encoding: .utf8) ?? "Nil Param")
            }
            var headers: [String:String] = [:]
            //            if let user = WalknTours.sharedInstance.currentUser {
            //                //headers["Content-Type"] = "application/json"
            //                headers[kSessionId] = user.sessionId
            //
            //            }
            
            //            Alamofire.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            Alamofire.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
                print(response)
                switch (response.result) {
                case .success(let value):
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) {
                        print("Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
                    }
                    success(value)
                case .failure(let error):
                    print(error.localizedDescription)
                    print(error)
                    failure(Constant.alertTitleMessage.internetNotAvailable)
                }
            }
        }
        else {
            connectionFailed(Constant.alertTitleMessage.internetNotAvailable)
        }
    }
    
    // MARK:- Call API to upload Single image with request data
    class func makeMultipartFormDataRequest(_ URLString: String,image : UIImage?,fileName:String, withSuccess success: @escaping (_ responseDictionary: Any) -> Void, failure: @escaping (_ error: String) -> Void, connectionFailed: @escaping (_ error: String) -> Void) {
        
        if(isConnectedToNetwork()) {
            let url = URL(string:URLString)!
            //            print(url)
            
            //            var jsonString = ""
            //            do {
            //                let jsonData = try JSONSerialization.data(withJSONObject: [:], options: JSONSerialization.WritingOptions.prettyPrinted)
            //                jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
            //                print(jsonString)
            //            } catch let error as NSError {
            //                print(error)
            //            }
            var headers: [String:String] = [:]
            
            Alamofire.upload(multipartFormData: { multipartFormData in
                
                if let img = image,let imageData = UIImageJPEGRepresentation(img, 0.6) {
                    multipartFormData.append(imageData, withName: "Photo", fileName: "Photo.jpg", mimeType: "image/jpg")
                }
                
            }, to: url, headers: headers, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _ , _ ):
                    upload.responseJSON { response in
                        debugPrint(response)
                        if response.response?.statusCode == 200 {
                            if let jsonData = try? JSONSerialization.data(withJSONObject: response.result.value!, options: .prettyPrinted) {
                                print("Response: \n",String(data: jsonData, encoding: String.Encoding.utf8) ?? "nil")
                            }
                            success(response.result.value! as AnyObject)
                        } else {
                            let res = response.result.value! as AnyObject
                            let msg = res["Message"] as? String
                            if msg != nil {
                                failure(msg!)
                            } else {
                                failure("")
                            }
                        }
                    }
                case .failure(let encodingError):
                    print(encodingError)
                    failure(encodingError.localizedDescription)
                }
            })
        } else {
            connectionFailed(Constant.alertTitleMessage.internetNotAvailable)
        }
    }
}
