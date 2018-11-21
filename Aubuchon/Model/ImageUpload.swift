//
//  ImageUpload.swift
//  Aubuchon
//
//  Created by mac on 15/11/18.
//  Copyright © 2018 Differenz. All rights reserved.
//


import UIKit
import SVProgressHUD

let kIsSuccess = "IsSuccess"
let kMessage = "Message"
let kStatusCode = "StatusCode"
let kpublicIp = "IpAddress"
class ImageUpload: NSObject {
    
    // MARK:- Image upload  function
    class func uploadImageData(with image:UIImage?, success withResponse: @escaping (_ response : String) -> (), failure: @escaping FailureBlock ) {
        
        SVProgressHUD.show()
        // Image upload API call
        APIManager.makeMultipartFormDataRequest(Constant.APIURLANDKEY.uploadImageApi,image: image,fileName:"Photo", withSuccess: { (response) in
            SVProgressHUD.dismiss()
            //print(response)
            let dict = response as? [String:Any] ?? [:]
            let issuccess = dict[kIsSuccess] as! Bool ?? false
            if issuccess {
                let message = dict[kMessage] as! String ?? ""
                withResponse(message)
            }
            
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            print(error)
            failure(error,false)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
        })
    }
    
    //MARK:- public IP check API call
    class func checkpublicIp(with publicIp:String, success withResponse: @escaping
        (_ response : String,_ isSuccess :Bool) -> (), failure: @escaping FailureBlock) {
        SVProgressHUD.show()
        let param: [String:Any] = [kpublicIp : publicIp]
        
        APIManager.makeRequest(with: Constant.APIURLANDKEY.publicIp, method: .post, parameter: param, success: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            let isSuccess = dict[kIsSuccess] as? Bool ?? false
            let message = dict[kMessage] as? String ?? ""
            
            if isSuccess{
                
                withResponse(message,isSuccess)
            }
            else {
                failure(message,isSuccess)
            }
            
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error,false)
            
        }) { (StringconnectionError) in
            SVProgressHUD.dismiss()
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
            
        }
    }
}
