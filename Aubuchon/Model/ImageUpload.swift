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
let kbarcode = "branchcode"
let kdata = "data"

let kPlanogram = "Planogram"
let kPlangramDesc = "PlangramDesc"
let kOneYrSales = "OneYrSales"
let kbuyer = "buyer"
let kcreateasigndesc = "create_a_sign_desc"
let kpurchunits = "purchunits"
let kSupplier = "Supplier"
let kSupplierName = "SupplierName"
let kDcStock = "DcStock"
let kprodcode = "prodcode"
let kOneYearSales = "OneYearSales"
let kproddesc = "proddesc"
let kimageURL = "imageURL"
let kClassName = "ClassName"
let kDepartmentName = "DepartmentName"
let kprodstatus = "prodstatus"
let kretailPrice = "retailPrice"
let kSubClassName = "SubClassName"
let kbranchcode = "branchcode"
let kORDNUM = "ORDNUM"
let kDiscDate = "DiscDate"
let kprodint = "prodint"
let kaltUPC = "altUPC"
let kStore = "store"
let kName = "name"
let kQty = "qty"

class StoreStock: NSObject {
    let store, name: String
    let qty: Int
    var storeINVData: [ImageUpload]
     init?(dictionary: [String:Any]) {
         self.storeINVData = (dictionary["StoreStock"] as? [[String:Any]] ?? [[:]]).compactMap(ImageUpload.init)
        self.store = dictionary[kStore] as? String ?? ""
        self.name = dictionary[kName] as? String ?? ""
        self.qty = dictionary[kQty] as? Int ?? 0
    }
    
}
class ImageUpload: NSObject, NSCoding {
    var Planogram:String
    var PlangramDesc:String
    var OneYrSales:Int
    var buyer:Int
    var createasigndesc:String
    var purchunits:String
    var Supplier:String
    var SupplierName:String
    var DcStock:Int
    var prodcode:String
    var OneYearSales:Int
    var proddesc:String
    var imageURL:String
    var ClassName:String
    var DepartmentName:String
    var prodstatus:String
    var retailPrice:String
    var SubClassName:String
    var branchcode:String
    var ORDNUM:String
    var DiscDate:String
    var prodint:Int
    var altUPC:String
    var store:String
    var storeName:String
    var qty:Int
   // var storeINVData:[ImageUpload]
    
    init?(dictionary: [String:Any]) {
        self.Planogram = dictionary[kPlanogram] as? String ?? ""
        self.PlangramDesc = dictionary[kPlangramDesc] as? String ?? ""
        self.OneYrSales = dictionary[kOneYrSales] as? Int ?? 0
        self.buyer = dictionary[kbuyer] as? Int ?? 0
        self.createasigndesc = dictionary[kcreateasigndesc] as? String ?? ""
        self.purchunits = dictionary[kpurchunits] as? String ?? ""
        self.Supplier = dictionary[kSupplier] as? String ?? ""
        self.SupplierName = dictionary[kSupplierName] as? String ?? ""
        self.DcStock = dictionary[kDcStock] as? Int ?? 0
        self.prodcode = dictionary[kprodcode] as? String ?? ""
        self.OneYearSales = dictionary[kOneYearSales] as? Int ?? 0
        self.proddesc = dictionary[kproddesc] as? String ?? ""
        self.imageURL = dictionary[kimageURL] as? String ?? ""
        self.ClassName = dictionary[kClassName] as? String ?? ""
        self.DepartmentName = dictionary[kDepartmentName] as? String ?? ""
        self.prodstatus = dictionary[kprodstatus] as? String ?? ""
        self.retailPrice = dictionary[kretailPrice] as? String ?? ""
        self.SubClassName = dictionary[kSubClassName] as? String ?? ""
        self.branchcode = dictionary[kbranchcode] as? String ?? ""
        self.ORDNUM = dictionary[kORDNUM] as? String ?? ""
        self.DiscDate = dictionary[kDiscDate] as? String ?? ""
        self.prodint = dictionary[kprodint] as? Int ?? 0
        self.altUPC = dictionary[kaltUPC] as? String ?? ""
        self.store = dictionary[kStore] as? String ?? ""
        self.storeName = dictionary[kName] as? String ?? ""
        self.qty = dictionary[kQty] as? Int ?? 0
       
        
        
    }
    
    // MARK: - NSCoding
    
    required init(coder aDecoder: NSCoder) {
        Planogram = aDecoder.decodeObject(forKey: kPlanogram) as? String ?? ""
        PlangramDesc = aDecoder.decodeObject(forKey: kPlangramDesc) as? String ?? ""
        OneYrSales = aDecoder.decodeObject(forKey: kOneYrSales) as? Int ?? 0
        buyer = aDecoder.decodeObject(forKey: kbuyer) as? Int ?? 0
        createasigndesc = aDecoder.decodeObject(forKey: kcreateasigndesc) as? String ?? ""
        purchunits = aDecoder.decodeObject(forKey: kpurchunits) as? String ?? ""
        Supplier = aDecoder.decodeObject(forKey: kSupplier) as? String ?? ""
        SupplierName = aDecoder.decodeObject(forKey: kSupplierName) as? String ?? ""
        DcStock = aDecoder.decodeObject(forKey: kDcStock) as? Int ?? 0
        prodcode = aDecoder.decodeObject(forKey: kprodcode) as? String ?? ""
        OneYearSales = aDecoder.decodeObject(forKey: kOneYearSales) as? Int ?? 0
        proddesc = aDecoder.decodeObject(forKey: kproddesc) as? String ?? ""
        imageURL = aDecoder.decodeObject(forKey: kimageURL) as? String ?? ""
        ClassName = aDecoder.decodeObject(forKey: kClassName) as? String ?? ""
        DepartmentName = aDecoder.decodeObject(forKey: kDepartmentName) as? String ?? ""
        prodstatus = aDecoder.decodeObject(forKey: kprodstatus) as? String ?? ""
        retailPrice = aDecoder.decodeObject(forKey: kretailPrice) as? String ?? ""
        SubClassName = aDecoder.decodeObject(forKey: kSubClassName) as? String ?? ""
        branchcode = aDecoder.decodeObject(forKey: kbranchcode) as? String ?? ""
        ORDNUM = aDecoder.decodeObject(forKey: kORDNUM) as? String ?? ""
        DiscDate = aDecoder.decodeObject(forKey: kDiscDate) as? String ?? ""
        prodint = aDecoder.decodeObject(forKey: kprodint) as? Int ?? 0
        altUPC = aDecoder.decodeObject(forKey: kaltUPC) as? String ?? ""
        store = aDecoder.decodeObject(forKey:kStore) as? String ?? ""
        storeName = aDecoder.decodeObject(forKey:kName) as? String ?? ""
        qty = aDecoder.decodeObject(forKey:kQty) as? Int ?? 0
       
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(Planogram, forKey: kPlanogram)
        aCoder.encode(PlangramDesc, forKey: kPlangramDesc)
        aCoder.encode(OneYrSales, forKey: kOneYrSales)
        aCoder.encode(buyer, forKey: kbuyer)
        aCoder.encode(createasigndesc, forKey: kcreateasigndesc)
        aCoder.encode(purchunits, forKey: kpurchunits)
        aCoder.encode(Supplier, forKey: kSupplier)
        aCoder.encode(SupplierName, forKey: kSupplierName)
        aCoder.encode(DcStock, forKey: kDcStock)
        aCoder.encode(prodcode, forKey: kprodcode)
        aCoder.encode(OneYearSales, forKey: kOneYearSales)
        aCoder.encode(proddesc, forKey: kproddesc)
        aCoder.encode(imageURL, forKey: kimageURL)
        aCoder.encode(ClassName, forKey: kClassName)
        aCoder.encode(DepartmentName, forKey: kDepartmentName)
        aCoder.encode(prodstatus, forKey: kprodstatus)
        aCoder.encode(retailPrice, forKey: kretailPrice)
        aCoder.encode(SubClassName, forKey: kSubClassName)
        aCoder.encode(branchcode, forKey: kbranchcode)
        aCoder.encode(ORDNUM, forKey: kORDNUM)
        aCoder.encode(DiscDate, forKey: kDiscDate)
        aCoder.encode(prodint, forKey: kprodint)
        aCoder.encode(altUPC, forKey: kaltUPC)
        aCoder.encode(store, forKey: kStore)
        aCoder.encode(storeName, forKey: kName)
        aCoder.encode(qty, forKey: kQty)
    }
    
    // MARK:- Image upload  function
    class func uploadImageData(with image:UIImage?, success withResponse: @escaping (_ response : String) -> (), failure: @escaping FailureBlock ) {
        SVProgressHUD.setDefaultMaskType(.black)
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
        SVProgressHUD.setDefaultMaskType(.black)
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
    
    //MARK:- display product information
    class func displayProductInfo(with branchcode: Int,
                                  data:String,
                                  success withResponse: @escaping (_ response : [String:Any], _ isSuccess: Bool, _ localINV: [StoreStock])-> (), failure: @escaping FailureBlock) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let param:[String:Any] = [kbarcode:branchcode,kdata:data]
      
        let barcodedata:String =  String(branchcode)
        let dataQuery:String = String(data)
        let queryString = Constant.APIURLANDKEY.productInfo + "?branchcode=\(barcodedata)" + "&data=\(dataQuery)"
        APIManager.makeRequestWithQueruyString(with: queryString , method: .post, parameter: param, success: { (response) in
            SVProgressHUD.dismiss()
            //print(response)
           // withResponse(response as! String, true)
            let dict = response as? [String:Any] ?? [:]
            //print(dict)
            
           let responseDic = dict["product"] as? [[String:Any]] ?? [[:]]
            let arrayStock = dict["StoreStock"] as? [[String:Any]] ?? [[:]]
            
          
            if responseDic.count == 0 {
               
                failure(Constant.alertTitleMessage.validBarcode,false)
            } else {
                
                let res = responseDic[0]
                

                var array1 = [StoreStock]()
                for i in arrayStock {
                    if let obj = StoreStock(dictionary: i){
                        array1.append(obj)
                    }
                }
                withResponse(res , true, array1)
            }

        }, failure: { (error) in
            SVProgressHUD.dismiss()
              failure(error,false)
        }) { (StringconnectionError) in
            SVProgressHUD.dismiss()
             failure(Constant.alertTitleMessage.internetNotAvailable,false)
        }
    }
    
    //MARK:- Display product information by form data
    class func displayProductInfoWIthFormData(with branchcode: Int, data:Int, success withResponse: @escaping (_ response : String,_ isSuccess: Bool)-> (), failure: @escaping FailureBlock) {
         SVProgressHUD.show()
    }
}
