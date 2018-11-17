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
            //  failure(0,error, .server)
        }, connectionFailed: { (connectionError) in
            SVProgressHUD.dismiss()
            //failure(0,connectionError, .connection)
        })
    }
}
