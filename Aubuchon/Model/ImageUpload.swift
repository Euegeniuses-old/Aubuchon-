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
let kLocalData = "local"

let kPlanogram = "Planogram"
let kPlangramDesc = "PlangramDesc"
let kOneYrSales = "OneYrSales"
let kbuyer = "buyer"
let kcreateasigndesc = "create_a_sign_desc"
let kpurchunits = "purchunits"
let kSupplier = "supplier"
let kSupplierName = "supplierName"
let kDcStock = "DcStock"
let kprodcode = "prodcode"
let kOneYearSales = "OneYearSales"
let kproddesc = "proddesc"
let kimageURL = "imageURL"
let kClassName = "ClassName"
let kDepartmentName = "DepartmentName"
let kprodstatus = "prodstatus"
let kProductStatusForProduct = "prodStatus"
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
let kMonStr = "monStr"
let kMon = "mon"
let kYr = "yr"
let kStoreStock = "StoreStock"
let kProduct = "product"
let kStoresByMonth = "StoresByMonth"
let  kCompanyByMonth = "CompanyByMonth"
let kRelatedProducts = "RelatedProducts"
let kSku = "sku"
let kPosDesc = "posDesc"
let kSection = "section"
let kSectionDesc = "sectionDesc"
let kSpeedNo = "speedNo"
let kOrdUnit = "ordUnit"
let kCompanyYrSales = "companyYrSales"
let kStoreYrSales = "storeYrSales"
let kLastSoldDate = "lastSoldDate"
let kLastDelDate = "lastDelDate"
let kOnHandAmt = "onHandAmt"
let kAvailable = "available"
let kOnOrderAmt = "onOrderAmt"
let kOnOrderPO = "onOrderPO"
let kDeliveryDate = "deliveryDate"
let kUrlKey = "url_key"
let kMinStk = "minStk"
let kMaxStk = "maxStk"
let kReOrdPoint = "reOrdPoint"
let kRating = "rating"
let kImage = "image"
let kwebDesc = "webDesc"
let kPromoPrice = "promoPrice"
let kRanking = "ranking"
//let kLocal = "local"
let kTable1 = "Table1"
let kTable2 = "Table2"
let kSalesByMonth = "SalesByMonth"
let kCompanyQty = "CompQty"
let kStoreQty = "storeQty"
let kSort = "Sort"
let kPoNo = "poNo"
let kOrderQty = "orderQty"
let kDelDate = "delDate"

//Local INV
class StoreStock: NSObject {
    var store, name: String
    var qty:Int
    var localData: Int
    // var storeINVData: [ImageUpload]
    init?(dictionary: [String:Any]) {
        //     self.storeINVData = (dictionary[kStoreStock] as? [[String:Any]] ?? [[:]]).compactMap(ImageUpload.init)
        self.store = dictionary[kStore] as? String ?? ""
        self.name = dictionary[kName] as? String ?? ""
        self.qty = dictionary[kQty] as? Int ?? 0
        self.localData = dictionary[kLocalData] as? Int ?? 2
    }
    
}

//Sales history
struct SalesByMonth: Codable {
    

    //EDITED:- 22-01-2019 Parth
    let monStr: String
    let storeQty, companyQty: Int
    let mon, yr, sort: Int
    
    init?(dictionary: [String:Any]) {
        self.companyQty = dictionary[kCompanyQty] as? Int ?? 0
        self.storeQty = dictionary[kStoreQty] as? Int ?? 0
        self.monStr = dictionary[kMonStr] as? String ?? ""
        self.mon = dictionary[kMon] as? Int ?? 0
        self.yr = dictionary[kYr] as? Int ?? 0
        self.sort = dictionary[kSort] as? Int ?? 0
    }
}
struct TableData: Codable {
    let poNo: String
    let orderQty: Int
    let delDate: String
     init?(dictionary: [String:Any]) {
        self.poNo = dictionary[kPoNo] as? String ?? ""
        self.orderQty = dictionary[kOrderQty] as? Int ?? 0
        self.delDate = dictionary[kDelDate] as? String ?? ""
    }
}


//Releted Product
struct RelatedProduct: Codable {
    let sku: String
    let image: String
    let webDesc: String
    let retailPrice: Double
    let promoPrice: String
    let ranking: Int
    //  let local: Int
    init?(dictionary: [String:Any]) {
        self.sku = dictionary[kSku] as? String ?? ""
        self.image = dictionary[kImage] as? String ?? ""
        self.webDesc = dictionary[kwebDesc] as? String ?? ""
        self.retailPrice = dictionary[kretailPrice] as? Double ?? 0
        self.promoPrice = dictionary[kPromoPrice] as? String ?? ""
        self.ranking = dictionary[kRanking] as? Int ?? 0
        //self.local = dictionary[kLocal] as? Int ?? 0
    }
}
class ProductOrderData: NSObject, NSCoding {
    let store, sku, webDesc, posDesc: String
    let departmentName, className, subClassName, section: String
    let sectionDesc, speedNo, ordUnit, discDate: String
    let prodStatus: String
    let retailPrice: Double
    let imageURL: String
    let companyYrSales, storeYrSales: Int
    let supplier, supplierName, promoPrice, lastSoldDate: String
    let lastDelDate: String
    let onHandAmt, available, onOrderAmt: Int
    let onOrderPO, deliveryDate: String
    let urlKey: String
    let minStk, maxStk, reOrdPoint: Int
    let rating: Double
    
     init?(dictionary: [String:Any]) {
        self.sku = dictionary[kSku] as? String ?? ""
        self.store = dictionary[kStore] as? String ?? ""
        self.webDesc = dictionary[kwebDesc] as? String ?? ""
        self.posDesc = dictionary[kPosDesc] as? String ?? ""
        self.departmentName = dictionary[kDepartmentName] as? String ?? ""
        self.className = dictionary[kClassName] as? String ?? ""
        self.subClassName = dictionary[kSubClassName] as? String ?? ""
        self.section = dictionary[kSection] as? String ?? ""
        self.sectionDesc = dictionary[kSectionDesc] as? String ?? ""
        self.speedNo = dictionary[kSpeedNo] as? String ?? ""
        self.ordUnit = dictionary[kOrdUnit] as? String ?? ""
        self.discDate = dictionary[kDiscDate] as? String ?? ""
        self.prodStatus = dictionary[kProductStatusForProduct] as? String ?? ""
        self.retailPrice = dictionary[kretailPrice] as? Double ?? 0
        self.imageURL = dictionary[kimageURL] as? String ?? ""
        self.companyYrSales = dictionary[kCompanyYrSales] as? Int ?? 0
        self.storeYrSales = dictionary[kStoreYrSales] as? Int ?? 0
        self.supplier = dictionary[kSupplier] as? String ?? ""
        self.supplierName = dictionary[kSupplierName] as? String ?? ""
        self.promoPrice = dictionary[kPromoPrice] as? String ?? ""
        self.lastSoldDate = dictionary[kLastSoldDate] as? String ?? ""
        self.lastDelDate = dictionary[kLastDelDate] as? String ?? ""
        self.onHandAmt = dictionary[kOnHandAmt] as? Int ?? 0
        self.available = dictionary[kAvailable] as? Int ?? 0
        self.onOrderAmt = dictionary[kOnOrderAmt] as? Int ?? 0
        self.onOrderPO = dictionary[kOnOrderPO] as? String ?? ""
        self.deliveryDate = dictionary[kDeliveryDate] as? String ?? ""
        self.urlKey = dictionary[kUrlKey] as? String ?? ""
        self.minStk = dictionary[kMinStk] as? Int ?? 0
        self.maxStk = dictionary[kMaxStk] as? Int ?? 0
        self.reOrdPoint = dictionary[kReOrdPoint] as? Int ?? 0
        self.rating = dictionary[kRating] as? Double ?? 0
        
    }
    
    required init(coder aDecoder: NSCoder) {
        sku = aDecoder.decodeObject(forKey: kSku) as? String ?? ""
        store = aDecoder.decodeObject(forKey: kStore) as? String ?? ""
        webDesc = aDecoder.decodeObject(forKey: kwebDesc) as? String ?? ""
        posDesc = aDecoder.decodeObject(forKey: kPosDesc) as? String ?? ""
        departmentName = aDecoder.decodeObject(forKey:kDepartmentName) as? String ?? ""
        className = aDecoder.decodeObject(forKey:kClassName) as? String ?? ""
        subClassName = aDecoder.decodeObject(forKey:kSubClassName) as? String ?? ""
        section = aDecoder.decodeObject(forKey:kSection) as? String ?? ""
        sectionDesc = aDecoder.decodeObject(forKey:kSectionDesc) as? String ?? ""
        speedNo = aDecoder.decodeObject(forKey:kSpeedNo) as? String ?? ""
        ordUnit = aDecoder.decodeObject(forKey:kOrdUnit) as? String ?? ""
        discDate = aDecoder.decodeObject(forKey:kDiscDate) as? String ?? ""
        prodStatus = aDecoder.decodeObject(forKey:kProductStatusForProduct) as? String ?? ""
        retailPrice = aDecoder.decodeObject(forKey:kretailPrice) as? Double ?? 0
        imageURL = aDecoder.decodeObject(forKey:kimageURL) as? String ?? ""
        companyYrSales = aDecoder.decodeObject(forKey:kCompanyYrSales) as? Int ?? 0
        storeYrSales = aDecoder.decodeObject(forKey:kStoreYrSales) as? Int ?? 0
        supplier = aDecoder.decodeObject(forKey:kSupplier) as? String ?? ""
        supplierName = aDecoder.decodeObject(forKey:kSupplierName) as? String ?? ""
        promoPrice = aDecoder.decodeObject(forKey:kPromoPrice) as? String ?? ""
        lastSoldDate = aDecoder.decodeObject(forKey:kLastSoldDate) as? String ?? ""
        lastDelDate = aDecoder.decodeObject(forKey:kLastDelDate) as? String ?? ""
        onHandAmt = aDecoder.decodeObject(forKey:kOnHandAmt) as? Int ?? 0
        available = aDecoder.decodeObject(forKey:kAvailable) as? Int ?? 0
        onOrderAmt = aDecoder.decodeObject(forKey:kOnOrderAmt) as? Int ?? 0
        onOrderPO = aDecoder.decodeObject(forKey:kOnOrderPO) as? String ?? ""
        deliveryDate = aDecoder.decodeObject(forKey:kDeliveryDate) as? String ?? ""
        urlKey = aDecoder.decodeObject(forKey:kUrlKey) as? String ?? ""
        minStk = aDecoder.decodeObject(forKey:kMinStk) as? Int ?? 0
        maxStk = aDecoder.decodeObject(forKey:kMaxStk) as? Int ?? 0
        reOrdPoint = aDecoder.decodeObject(forKey:kReOrdPoint) as? Int ?? 0
        rating = aDecoder.decodeObject(forKey:kRating) as? Double ?? 0
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(sku, forKey: kSku)
        aCoder.encode(store, forKey: kStore)
        aCoder.encode(webDesc, forKey: kwebDesc)
        aCoder.encode(posDesc, forKey: kPosDesc)
        aCoder.encode(departmentName, forKey: kDepartmentName)
        aCoder.encode(className, forKey: kClassName)
        aCoder.encode(subClassName, forKey: kSubClassName)
        aCoder.encode(section, forKey: kSection)
        aCoder.encode(sectionDesc, forKey: kSectionDesc)
        aCoder.encode(speedNo, forKey: kSpeedNo)
        aCoder.encode(ordUnit, forKey: kOrdUnit)
        aCoder.encode(discDate, forKey: kDiscDate)
        aCoder.encode(prodStatus, forKey: kProductStatusForProduct)
        aCoder.encode(retailPrice, forKey: kretailPrice)
        aCoder.encode(imageURL, forKey: kimageURL)
        aCoder.encode(companyYrSales, forKey: kCompanyYrSales)
        aCoder.encode(storeYrSales, forKey: kStoreYrSales)
        aCoder.encode(supplier, forKey: kSupplier)
        aCoder.encode(supplierName, forKey: kSupplierName)
        aCoder.encode(promoPrice, forKey: kPromoPrice)
        aCoder.encode(lastSoldDate, forKey: kLastSoldDate)
        aCoder.encode(lastDelDate, forKey: kLastDelDate)
        aCoder.encode(onHandAmt, forKey: kOnHandAmt)
        aCoder.encode(available, forKey: kAvailable)
        aCoder.encode(onOrderAmt, forKey: kOnOrderAmt)
        aCoder.encode(onOrderPO, forKey: kOnOrderPO)
        aCoder.encode(deliveryDate, forKey: kDeliveryDate)
        aCoder.encode(urlKey, forKey: kUrlKey)
        aCoder.encode(minStk, forKey: kMinStk)
        aCoder.encode(maxStk, forKey: kMaxStk)
        aCoder.encode(reOrdPoint, forKey: kReOrdPoint)
        aCoder.encode(rating, forKey: kRating)
    }
    
    //Save project object in UserDefault
    func saveProductDataInDefault() {
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(encodedData, forKey: Constant.UserDefaultsKey.kProductInfo)
    }
    
    //Get project object from UserDefault
    class func getProductDataFromDefault() -> ProductOrderData? {
        if let decoded  = UserDefaults.standard.data(forKey: Constant.UserDefaultsKey.kProductInfo), let productDataInfo = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? ProductOrderData {
            return productDataInfo
        }
        return nil
    }
    
    //Remove project object from UserDefault
    class func removeProductDataFromDefault() {
        UserDefaults.standard.set(nil, forKey: Constant.UserDefaultsKey.kProductInfo)
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
    
   
    
    //MARK:- call API For brachcode
    class func callBrachcodeAPI(success withResponse: @escaping (_ response : [String:Any])-> (), failure: @escaping FailureBlock) {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        APIManager.makeRequestWithQueruyString(with: Constant.APIURLANDKEY.fetchBranchCode , method: .post, parameter: nil, success: { (response) in
            SVProgressHUD.dismiss()
            let dict = response as? [String:Any] ?? [:]
            withResponse(dict)
        }, failure: { (error) in
            SVProgressHUD.dismiss()
            failure(error,false)
        }) { (StringconnectionError) in
            SVProgressHUD.dismiss()
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
        }
        
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
}

class Product {
    
    //MARK:- Display product information by form data
    class func displayProductInfoWIthFormData(with branchcode: Int, data:Int, success withResponse: @escaping (_ response : String,_ isSuccess: Bool)-> (), failure: @escaping FailureBlock) {
        SVProgressHUD.show()
    }
    
    //MARK:- display product information
    class func displayProductInfo(with branchcode: String,
                                  data:String,
                                  success withResponse: @escaping (_ response : ProductOrderData, _ isSuccess: Bool, _ arrUPC:[[String:Any]], _ arrtableTwo:[TableData])-> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let param:[String:Any] = [kbarcode:branchcode,kdata:data]
        
        let barcodedata:String =  String(branchcode)
        let dataQuery:String = String(data)
        let queryString = Constant.APIURLANDKEY.productInfo + "?branchcode=\(barcodedata)" + "&data=\(dataQuery)"
        
        APIManager.makeRequestWithQueruyString(with: queryString , method: .post, parameter: param, success: { (response) in
           // SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show()
            let dict = response as? [String:Any] ?? [:]
            
            let responseDic = dict[kProduct] as? [[String:Any]] ?? [[:]]
            let arrUPC = dict[kTable1] as? [[String:Any]] ?? [[:]] //Table1
            let table2Array = dict[kTable2] as? [[String:Any]] ?? [[:]] //Table2
            
            
            if responseDic.count == 0 {
                SVProgressHUD.dismiss()
                failure(Constant.alertTitleMessage.validBarcode,false)
            } else {
                
                let res = responseDic[0]
                let product = ProductOrderData.init(dictionary: res)
                UserDefaults.productData = true
               // product?.saveProductDataInDefault()
               // singaltan.aubuchon.productData = product
                var arraytable2 = [TableData]()
                for i in table2Array {
                    if let table2ArrayObj = TableData(dictionary: i) {
                        arraytable2.append(table2ArrayObj)
                    }
                }
                withResponse(product!,true,arrUPC,arraytable2)
            }
        }, failure: { (error) in
            failure(error,false)
            SVProgressHUD.dismiss()
            
        }) { (StringconnectionError) in
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
            SVProgressHUD.dismiss()
            
        }
    }
    
    //MARK:- call APIFor Sales-History
    class func callAPIForSalesHistory(with branchcode: String, strBarcode:String, success withResponse: @escaping (_ response : [String:Any], _ isSuccess: Bool,_ storeByMonth:[SalesByMonth])-> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let param:[String:Any] = [kbarcode:branchcode,kdata:strBarcode]
        
        let barcodedata:String =  String(branchcode)
        
        let queryString = Constant.APIURLANDKEY.kGetSalesHistory + "?branchcode=\(barcodedata)" + "&data=\(strBarcode)"
        
        APIManager.makeRequestWithQueruyString(with: queryString , method: .post, parameter: param, success: { (response) in
           // SVProgressHUD.dismiss()
            
            let dict = response as? [String:Any] ?? [:]
            
            let responseDic = dict[kProduct] as? [[String:Any]] ?? [[:]]
            let responseStoresByMonth = dict[kSalesByMonth] as? [[String:Any]] ?? [[:]]
            
            if responseDic.count == 0 {
                
                failure(Constant.alertTitleMessage.validBarcode,false)
            } else {
                
                let res = responseDic[0]
                
                //Sales history
                var arrayStoresByMonth = [SalesByMonth]()
                for i in responseStoresByMonth {
                    if let storesByMonthObj = SalesByMonth(dictionary: i) {
                        arrayStoresByMonth.append(storesByMonthObj)
                    }
                }
                withResponse(res,true,arrayStoresByMonth)
            }
            
        }, failure: { (error) in
         //   SVProgressHUD.dismiss()
            failure(error,false)
        }) { (StringconnectionError) in
          //  SVProgressHUD.dismiss()
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
        }
    }
    
    //MARK:- call API For LocalINV
    class func callAPIForLocalINV(with branchcode: String,
                                  data:String,
                                  success withResponse: @escaping (_ response : [String:Any], _ isSuccess: Bool, _ localINV: [StoreStock])-> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        let param:[String:Any] = [kbarcode:branchcode,kdata:data]
        
        let queryString = Constant.APIURLANDKEY.kGetLocalINV + "?branchcode=\(branchcode)" + "&data=\(data)"
        
        APIManager.makeRequestWithQueruyString(with: queryString , method: .post, parameter: param, success: { (response) in
           // SVProgressHUD.dismiss()
            
            let dict = response as? [String:Any] ?? [:]
            
            let responseDic = dict[kProduct] as? [[String:Any]] ?? [[:]]
            let arrayStock = dict[kStoreStock] as? [[String:Any]] ?? [[:]]
            
            if responseDic.count == 0 {
                
                failure(Constant.alertTitleMessage.validBarcode,false)
            } else {
                
                let res = responseDic[0]
                
                //Local INV
                var array1 = [StoreStock]()
                for i in arrayStock {
                    if let obj = StoreStock(dictionary: i){
                        array1.append(obj)
                    }
                }
                withResponse(res,true,array1)
            }
            
        }, failure: { (error) in
          //  SVProgressHUD.dismiss()
            failure(error,false)
        }) { (StringconnectionError) in
          //  SVProgressHUD.dismiss()
            failure(Constant.alertTitleMessage.internetNotAvailable,false)
        }
    }
    
    //MARK:- call API For Releted Product
    class func callAPIForReletedProduct(with branchcode: String,
                                        data:String,
                                        success withResponse: @escaping (_ response : [String:Any], _ isSuccess: Bool, _ arrReletedProduct: [RelatedProduct])-> (), failure: @escaping FailureBlock) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
        let param:[String:Any] = [kbarcode:branchcode,kdata:data]
        let queryString = Constant.APIURLANDKEY.kGetReletedProduct + "?branchcode=\(branchcode)" + "&data=\(data)"
        
        APIManager.makeRequestWithQueruyString(with: queryString , method: .post, parameter: param, success: { (response) in
            SVProgressHUD.dismiss()
            
            let dict = response as? [String:Any] ?? [:]
            
            let responseDic = dict[kProduct] as? [[String:Any]] ?? [[:]]
            let responseRelatedItems = dict[kRelatedProducts] as? [[String:Any]] ?? [[:]]
            
            if responseDic.count == 0 {
                
                failure(Constant.alertTitleMessage.validBarcode,false)
            } else {
                
                let res = responseDic[0]
                
                //Releted Product
                var arrayRelatedProduct = [RelatedProduct]()
                for i in responseRelatedItems{
                    if let relatedProductObj = RelatedProduct(dictionary: i) {
                        arrayRelatedProduct.append(relatedProductObj)
                    }
                }
                
                withResponse(res,true,arrayRelatedProduct)
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
