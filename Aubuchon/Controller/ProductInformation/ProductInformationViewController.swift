//
//  ProductInformationViewController.swift
//  Aubuchon
//
//  Created by mac on 11/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
struct Objects {
    var inqueryTitle : String!
    var inqueryValues : String!
    var id:Int!
}

struct orderInfoObjects {
    var orderInfoTitle : String!
    var orderInfoValues : String!
    var id:Int!
}

let kBranchCode = "049"

class ProductInformationViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //Outlets
    @IBOutlet weak var btnInquery: UIButton!
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnLocalINV: UIButton!
    @IBOutlet weak var btnOrderInfo: UIButton!
    @IBOutlet weak var btnSalesHistory: UIButton!
    @IBOutlet weak var btnRelatedIntems: UIButton!
    @IBOutlet weak var btnTBDOne: UIButton!
    @IBOutlet weak var btnTBDTwo: UIButton!
    
    @IBOutlet weak var lblNoData: UILabel!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var collectionViewCell: UICollectionViewCell!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var buttonsView: UIView!
    @IBOutlet weak var lblSKU: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var tblMenu: UITableView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var skuView: UIView!
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var btnInqueryLeadingConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var lblMoreUndreLine: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    
    // Variables
    var isDataFound:Bool = false{
        didSet {
            if !isDataFound{
                self.lblNoData.isHidden = false
            }else{
                self.lblNoData.isHidden = true
            }
        }
    }
    
    var strProductUrl:String = ""
    var barcode : String = ""
    var screen : Int = 1
    var productData = [ImageUpload]()
    var image:String = ""
    var inquiryArray : [String] = ["Item Number","UPC","Desc","Price","Promo","OH","Available","Section","Speed#", "Status"]
    var inquiryValue:[String] = []
    var inqueryData : [String:Any] = [:]
    var objProductOrderInfo: ProductOrderData?
    var objectsArray = [Objects]()
    var onderInfoArray = [orderInfoObjects]()
    var tableTwoArrayForOrderInfo = [TableData]()
    var tableTwoUniqueDataForOrderInfo = [TableData]()
    //var tableTwoUniqueDataForOrderInfo:[String] = []
    var menu : [String] = ["Home","Product Info"]
    var isMenuVisible : Bool = false
    var dataforInquery:String = ""
    var dataforOrderInfo:String = ""
    var isfromBack:Bool = false
    
    var storeStockArray = [StoreStock]()
    var sortedStoreStock:[StoreStock] = []
    var sortedNearestStock:[StoreStock] = []
    var storeFinalStockArray:[StoreStock] = []
    var salesByMonthArray = [SalesByMonth]()
    var storeRelatedProductArray = [RelatedProduct]()
    var dateCheckArray:[String] = ["2019-01-27","2019-01-28","2019-02-02","2019-02-18","2019-02-19","2019-02-11","2019-05-15","2019-10-16"]
    var QtyCheckData:[String] = ["123456","234567","789543","478965","36874","789654","423674","123456"]
    var tableTwoDatecheck :[String] = []
    var poNo:String = ""
    var delDate:String = ""
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        navigationConfig()
        hideMenuView()
        registerXib()
        uiButtons()
        removeAllArrayData()
        uiConfig()
        //CALL API's
        self.GetProductDetails(barcodeForProduct: self.barcode)
        
        NotificationCenter.default.addObserver(self, selector:#selector(relatedItemsCelldataNotification), name: NSNotification.Name(rawValue: "relatedItemsCelldata"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(self.lblSKUTapped))
        tapGest.numberOfTapsRequired = 1
        self.lblSKU.isUserInteractionEnabled = true
        self.lblSKU.addGestureRecognizer(tapGest)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //remove  notification
        NotificationCenter.default.removeObserver("relatedItemsCelldata")
    }
    
    @objc func relatedItemsCelldataNotification(notification: NSNotification) {
        screen = 1
        buttonColorFormattor(button: btnInquery)
        isfromBack = false
        self.btnBack.isHidden = false
        self.removeAllArrayData()
        barcode = Constant.kAppDelegate.relatedItemCellSku
         self.productTableView.reloadData()
        GetProductDetails(barcodeForProduct: Constant.kAppDelegate.relatedItemCellSku)
        
    }
    
    @objc func lblSKUTapped() {

        Constant.kAppDelegate.isBackFromProduct = true
        moveOnMainScreen(isFromSKU: true)
    }
    func setUpProductData()  {
        //Set inquiry tab data
        self.image = self.objProductOrderInfo?.imageURL ?? ""

        btnPhoto.isEnabled = self.image == "" ? false : true
        btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
        if screen == 2 {
            btnPhoto.setTitleColor(.black, for: .normal)
        }
        var sku:String = self.objProductOrderInfo?.sku ?? ""
        self.lblSKU.text = (" SKU:\(sku) ")
        self.objectsArray.append(Objects(inqueryTitle: "Item Number" , inqueryValues: self.objProductOrderInfo?.sku ?? "-",id:1))
        
        if let urlIs = self.objProductOrderInfo?.urlKey {
            self.strProductUrl = urlIs
        }
        
        if let Price = self.objProductOrderInfo?.retailPrice {
            self.dataforInquery = String(Price)
        } else {
            self.dataforInquery = "-"
        }
        self.objectsArray.append(Objects(inqueryTitle: "Price" , inqueryValues: self.dataforInquery ,id:8))
        
        if self.objProductOrderInfo?.promoPrice == "" {
            self.objectsArray.append(Objects(inqueryTitle: "Promo" , inqueryValues: "-",id:9))
        } else {
            self.objectsArray.append(Objects(inqueryTitle: "Promo" , inqueryValues: self.objProductOrderInfo?.promoPrice ?? "-",id:9))
        }
        
        if let onHandAmtdata = self.objProductOrderInfo?.onHandAmt {
            self.dataforInquery = String(onHandAmtdata)
        } else {
            self.dataforInquery = "-"
        }
         self.objectsArray.append(Objects(inqueryTitle: "On Hand" , inqueryValues: self.dataforInquery ,id:7))
        
        if let availableData =  self.objProductOrderInfo?.available {
            self.dataforInquery = String(availableData)
        } else {
            self.dataforInquery = "-"
        }
        
        self.objectsArray.append(Objects(inqueryTitle: "Available" , inqueryValues:self.dataforInquery ,id:6))
        
        if self.objProductOrderInfo?.section == "" {
            self.objectsArray.append(Objects(inqueryTitle: "Section" , inqueryValues:  "-",id:4))
        } else {
            self.objectsArray.append(Objects(inqueryTitle: "Section" , inqueryValues: self.objProductOrderInfo?.section ?? "-",id:4))
        }
        
        if singaltan.aubuchon.productData?.speedNo == "" {
             self.objectsArray.append(Objects(inqueryTitle: "Speed#" , inqueryValues: "-",id:5))
        } else {
            self.objectsArray.append(Objects(inqueryTitle: "Speed#" , inqueryValues: self.objProductOrderInfo?.speedNo ?? "-",id:5))
        }
        
        if self.objProductOrderInfo?.prodStatus == "" {
             self.objectsArray.append(Objects(inqueryTitle: "Status" , inqueryValues: "-",id:10))
        } else {
            self.objectsArray.append(Objects(inqueryTitle: "Status" , inqueryValues: self.objProductOrderInfo?.prodStatus,id:10))
        }
        
        self.lblMoreUndreLine.isHidden = false
        self.btnMore.isHidden = false
        let desc = self.objProductOrderInfo?.posDesc
        self.lblDesc.text =  desc ?? ""
        
        if desc == "" {
             self.objectsArray.append(Objects(inqueryTitle: "Desc" , inqueryValues: "-",id:3))
        } else {
            self.objectsArray.append(Objects(inqueryTitle: "Desc" , inqueryValues: self.objProductOrderInfo?.posDesc ?? "-",id:3))
        }
        //On set Order Info arr
        if self.objProductOrderInfo?.lastSoldDate == "" {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Last Sold" , orderInfoValues:"-",id:1))
        } else {
            let resultString = convertDateFormater(self.objProductOrderInfo?.lastSoldDate ?? "")
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Last Sold" , orderInfoValues:resultString,id:1))
        }
        
        if let onOrderAmtdata = self.objProductOrderInfo?.onOrderAmt {
            
            self.dataforOrderInfo = String(onOrderAmtdata)
        } else {
            self.dataforOrderInfo = "-"
        }
        self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "QTY on Order" , orderInfoValues: self.dataforOrderInfo,id:2))
        
        if let onOrderAmtdata = self.objProductOrderInfo?.onOrderPO {
            if onOrderAmtdata == "" {
                self.dataforOrderInfo = "-"
            } else {
                self.dataforOrderInfo = String(onOrderAmtdata)
            }
            
        }else{
            self.dataforOrderInfo = "-"
        }
        
        self.poNo =  self.dataforOrderInfo
        self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "PO Number", orderInfoValues: self.dataforOrderInfo,id:3))
        
        self.delDate = self.objProductOrderInfo?.deliveryDate ?? ""
        if self.objProductOrderInfo?.deliveryDate == "" {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Delivery Date" , orderInfoValues:"-",id:4))
        } else {
            let resultString = convertDateFormater(self.objProductOrderInfo?.deliveryDate ?? "")
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Delivery Date" , orderInfoValues:resultString,id:4))
        }
        
        if self.objProductOrderInfo?.supplierName == "" {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Primary Vendor" , orderInfoValues: "-",id:5))
        } else {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Primary Vendor" , orderInfoValues:self.objProductOrderInfo?.supplierName ?? "-",id:5))
        }
        if self.objProductOrderInfo?.supplier == "" {
             self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Vendor#" , orderInfoValues: "-",id:6))
        } else {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Vendor#" , orderInfoValues:self.objProductOrderInfo?.supplier ?? "-",id:6))
        }
        
        if let minValue = self.objProductOrderInfo?.minStk {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Min" , orderInfoValues: "\(minValue)",id:7))
        } else {
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Min" , orderInfoValues: "-",id:7))
        }
        
        if let maxValue = self.objProductOrderInfo?.maxStk{
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Max" , orderInfoValues: "\(maxValue)",id:8))
        }else{
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Max" , orderInfoValues: "-",id:8))
        }
        
        if let reOrderValue = self.objProductOrderInfo?.reOrdPoint{
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Reorder" , orderInfoValues: "\(reOrderValue)",id:9))
        }else{
            self.onderInfoArray.append(orderInfoObjects(orderInfoTitle: "Reorder" , orderInfoValues: "-",id:9))
        }
        
    }
    
    func convertDateFormater(_ date: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MM/dd/YY"
        return  dateFormatter.string(from: date!)
        
    }
    
    //MARK:- CALL API's
    func GetProductDetails(barcodeForProduct:String) {
        
        Product.displayProductInfo(with: singaltan.aubuchon.branchCode, data: barcodeForProduct, success: { (response, isSuccess, arrUPCData,table2Array)  in
            
            //self.inqueryData = response
            response.saveProductDataInDefault()
            singaltan.aubuchon.productData = response
            self.objProductOrderInfo = response
            self.tableTwoArrayForOrderInfo = table2Array
            
          //  if let statusIs = response["prodStatus"] as? String{
            
           // }else{
           //     self.objectsArray.append(Objects(inqueryTitle: "Status" , inqueryValues: "-",id:10))
           // }
            
            if self.isfromBack == true {
                self.btnBack.isHidden = true
            }
            
          //  if response.count != 0 {
                if Constant.kAppDelegate.isOldProductData != true {
                    self.storeDataInUserDefault()
                    Constant.kAppDelegate.isOldProductData = true
                }
                
                //On set product detail
//                for (nameIs, valueIs) in response   {
//                    self.onSetupProductData(key: nameIs, value: valueIs)
//                }
                    self.setUpProductData()
                for (_ ,dict) in arrUPCData.enumerated(){
                    if let isPrimary = dict["Primary"] as? Bool, isPrimary{
                        if let UPCIs = dict["altUPC"] as? String{
                            self.objectsArray.append(Objects(inqueryTitle: "UPC" , inqueryValues: UPCIs ,id:2))
                        }
                    }
                }
                if self.tableTwoArrayForOrderInfo.count > 0 {
                    for i in 0...self.tableTwoArrayForOrderInfo.count - 1 {
                        if self.tableTwoArrayForOrderInfo[i].poNo != self.poNo && self.tableTwoArrayForOrderInfo[i].delDate != self.delDate{
                            self.tableTwoUniqueDataForOrderInfo.append(self.tableTwoArrayForOrderInfo[i])
                        }
                    }
                }
                

                self.tableTwoUniqueDataForOrderInfo.sort(by:{$0.delDate.compare($1.delDate) == .orderedAscending})
                self.objectsArray.sort(by: { $0.id < $1.id })
                self.onderInfoArray.sort(by:{$0.id < $1.id})
                
                //FIXME:- New Changes Parth 22-jan-2019
                
                //Make sales history call
                self.GetSalesHistory(branchCode: singaltan.aubuchon.branchCode, strBarcode: barcodeForProduct)
                
                //Make Releted products call
                self.GetRelatedProducts(branchCode: singaltan.aubuchon.branchCode, strBarcode: barcodeForProduct)
                
                //Make Local INV call
                self.GetLocalNV(branchCode: singaltan.aubuchon.branchCode, strBarcode: barcodeForProduct)
                
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
                
//            } else {
//                // UserDefaults.standard.setCurrentSKU(value: "")
//                DispatchQueue.main.async {
//                    UserDefaults.standard.setOldSKU(value: UserDefaults.standard.getCurrentSKU())
//                    let alert = UIAlertController(title: "", message: Constant.alertTitleMessage.validBarcode, preferredStyle: UIAlertController.Style.alert)
//
//                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
//                        Constant.kAppDelegate.isBackFromProduct = true
//                        //self.dismiss(animated: false, completion: nil)
//                        self.moveOnMainScreen()
//
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                }
//            }
        }) { (response, issuccess) in
            //self.productTableView.reloadData()
            if response == Constant.alertTitleMessage.validBarcode {
                DispatchQueue.main.async {
                    UserDefaults.standard.setOldSKU(value: UserDefaults.standard.getCurrentSKU())
                    let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                        Constant.kAppDelegate.isBackFromProduct = true
                        // self.dismiss(animated: false, completion: nil)
                        self.moveOnMainScreen(isFromSKU: false)
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.alertMessage(message: response, title: "")
            }
        }
    }
    
    func GetSalesHistory(branchCode:String, strBarcode:String) {
        
        Product.callAPIForSalesHistory(with: branchCode, strBarcode: strBarcode, success: { (dictProduct, isSuccess, arrSalesByMonth) in
            
            self.salesByMonthArray = arrSalesByMonth
            self.salesByMonthArray.sort(by: { $0.yr > $1.yr})
            
        }) { (errorIs, failure) in
             //self.productTableView.reloadData()
          //  self.alertMessage(message: "Sales History detail Not Found", title: "")
        }
    }
    
    func GetLocalNV(branchCode:String, strBarcode:String) {
        
        Product.callAPIForLocalINV(with: branchCode, data: strBarcode, success: { (dictProduct, isSuccess, arrStock) in
            
            self.storeStockArray = arrStock
            self.storeStockArray.sort(by: { ($0.localData > $1.localData)})
            if self.storeStockArray.count > 0 {
            for index in 0...self.storeStockArray.count - 1 {
                if self.storeStockArray[index].localData == 1 {
                    self.sortedNearestStock.append(self.storeStockArray[index])
                    
                } else {
                    self.sortedStoreStock.append(self.storeStockArray[index])
                    
                }
                }
            }
            self.sortedNearestStock.sort(by:{$0.name.lowercased() < $1.name.lowercased()})
            self.sortedStoreStock.sort(by:{$0.name.lowercased() < $1.name.lowercased()})
            self.storeFinalStockArray =  self.sortedNearestStock + self.sortedStoreStock
            
        }) { (errorIs, failure) in
//             self.productTableView.reloadData()
          //  self.alertMessage(message: "LocalINV detail Not Found", title: "")
        }
    }
    
    func GetRelatedProducts(branchCode:String, strBarcode:String) {
        
        Product.callAPIForReletedProduct(with: branchCode, data: strBarcode, success: { (dictProduct, isSuccess, arrReletedProduct) in
            
            self.storeRelatedProductArray = arrReletedProduct
            
        }) { (errorIs, failure) in
            // self.productTableView.reloadData()
           // self.alertMessage(message: "Related Product detail Not Found", title: "")
        }
    }
    
    
    //MARK:- Button actions
    //btninquery action
    @IBAction func btnInquiry_Action(_ sender: Any) {
        screen = 1
        buttonColorFormattor(button: btnInquery)
        self.productTableView.reloadData()
    }
    
    //btnphoto action
    @IBAction func btnPhoto_Action(_ sender: Any) {
        screen = 2
        buttonColorFormattor(button: btnPhoto)
        self.productTableView.reloadData()
    }
    
    //btnLocalInv action
    @IBAction func btnLocalINV_Action(_ sender: Any) {
        screen = 3
        
        
        buttonColorFormattor(button: btnLocalINV)
        self.productTableView.reloadData()
    }
    
    //btnorderInfo action
    @IBAction func btnOrderInfo_Action(_ sender: Any) {
        screen = 4
        buttonColorFormattor(button: btnOrderInfo)
        self.productTableView.reloadData()
    }
    
    //btnsaleshistory action
    @IBAction func btnSalesHistory_Action(_ sender: Any) {
        screen = 5
        buttonColorFormattor(button: btnSalesHistory)
        
        self.productTableView.reloadData()
    }
    
    //btnRelatedItems action
    @IBAction func btnRelatedItems_Action(_ sender: Any) {
        screen = 6
        buttonColorFormattor(button: btnRelatedIntems)
        
        self.productTableView.reloadData()
    }
    
    @IBAction func btnReview_Action(_ sender: Any) {
        buttonColorFormattor(button: btnTBDOne)
        screen = 7
        self.productTableView.reloadData()
    }
    
    @IBAction func btnTBDtwo_Action(_ sender: Any) {
        buttonColorFormattor(button: btnTBDTwo)
        screen = 8
        self.productTableView.reloadData()
    }
    // barcode action
    @IBAction func btnBarcode_Action(_ sender: Any) {
        hideMenuView()
        Constant.kAppDelegate.isOldProductData = false
        // Constant.kAppDelegate.isBackFromProduct = true
        // self.dismiss(animated: false, completion: nil)
        openMTBScanner()
    }
    
    // menu action
    @IBAction func btnMenu(_ sender: Any) {
        showAndHideFilterMenu()
    }
    
    @IBAction func btnMore_Action(_ sender: Any) {
        if screen != 1 {
            screen = 1
            buttonColorFormattor(button: btnInquery)
            productTableView.reloadData()
            isfromBack = false
        }
    }
    
    @IBAction func btnBack_Action(_ sender: Any) {
        self.removeAllArrayData()
        Constant.kAppDelegate.isOldProductData = false
        isfromBack = true
        //lblSKU.text = "SKU:\(UserDefaults.standard.getOldSKU())"
        barcode = UserDefaults.standard.getOldSKU()
        GetProductDetails(barcodeForProduct: UserDefaults.standard.getOldSKU())

    }
    
    
    
    //MARK:- Private functions
    
    func removeAllArrayData() {
        objectsArray.removeAll()
        storeStockArray.removeAll()
        salesByMonthArray.removeAll()
        onderInfoArray.removeAll()
        storeRelatedProductArray.removeAll()
        sortedStoreStock.removeAll()
        sortedNearestStock.removeAll()
        storeFinalStockArray.removeAll()
    }
    
    func uiConfig() {
        isfromBack = false
        screen = 1
        btnInquery.backgroundColor = UIColor.black
        btnInquery.setTitleColor(.white, for: .normal)
        
        menuView.layer.borderColor = UIColor.black.cgColor
        menuView.layer.borderWidth = 1
        
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        
        lblSKU.layer.borderColor = UIColor.black.cgColor
        lblSKU.layer.borderWidth = 1
        lblSKU.layer.cornerRadius = 5
        
    }
    
    // Open  MTBScanner
    func openMTBScanner() {
        if(UIImagePickerController.isSourceTypeAvailable(.camera)) {
            let  ScannerVC:
                ScannerViewController = UIStoryboard(
                    name: "Main", bundle: nil
                    ).instantiateViewController(withIdentifier: "ScannerView") as! ScannerViewController
            ScannerVC.isFromMain = false
            self.present(ScannerVC, animated: false, completion: nil)
        } else {
            self.alertMessage(message: Constant.alertTitleMessage.cameranotfoundAlertMessage, title: Constant.alertTitleMessage.cameranotfoundTitleMessage)
        }
    }
    
    fileprivate func buttonColorFormattor(button:UIButton) {
        if button == btnInquery {
            btnInquery.backgroundColor = UIColor.black
            btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            
            btnInquery.setTitleColor(.white, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
           
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnPhoto {
            btnPhoto.backgroundColor = UIColor.black
            btnInquery.backgroundColor = UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnPhoto.setTitleColor(.white, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnLocalINV {
            btnLocalINV.backgroundColor = UIColor.black
           btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnInquery.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnLocalINV.setTitleColor(.white, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnOrderInfo {
            btnOrderInfo.backgroundColor = UIColor.black
            btnInquery.backgroundColor = UIColor.white
            btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnOrderInfo.setTitleColor(.white, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnSalesHistory {
            btnSalesHistory.backgroundColor = UIColor.black
            btnInquery.backgroundColor = UIColor.white
            btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnSalesHistory.setTitleColor(.white, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnRelatedIntems {
            btnRelatedIntems.backgroundColor = UIColor.black
            btnInquery.backgroundColor = UIColor.white
            btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnTBDOne.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnRelatedIntems.setTitleColor(.white, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnTBDOne {
            btnTBDOne.backgroundColor = UIColor.black
            btnRelatedIntems.backgroundColor = UIColor.white
            btnInquery.backgroundColor = UIColor.white
            btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            btnTBDTwo.backgroundColor = UIColor.white
            
            btnTBDOne.setTitleColor(.white, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnTBDTwo.setTitleColor(.black, for: .normal)
        } else if button == btnTBDTwo {
            btnTBDTwo.backgroundColor = UIColor.black
            btnTBDOne.backgroundColor = UIColor.white
            btnRelatedIntems.backgroundColor = UIColor.white
            btnInquery.backgroundColor = UIColor.white
           btnPhoto.backgroundColor = self.image == "" ? Constant.Colors.color_gray : UIColor.white
            btnLocalINV.backgroundColor = UIColor.white
            btnOrderInfo.backgroundColor = UIColor.white
            btnSalesHistory.backgroundColor = UIColor.white
            
            btnTBDTwo.setTitleColor(.white, for: .normal)
            btnRelatedIntems.setTitleColor(.black, for: .normal)
            btnInquery.setTitleColor(.black, for: .normal)
            btnPhoto.setTitleColor(.black, for: .normal)
            btnLocalINV.setTitleColor(.black, for: .normal)
            btnOrderInfo.setTitleColor(.black, for: .normal)
            btnSalesHistory.setTitleColor(.black, for: .normal)
            btnTBDOne.setTitleColor(.black, for: .normal)
        }
    }
    
    func storeDataInUserDefault() {
        let currentSKU:String = UserDefaults.standard.getCurrentSKU()
        let oldSKU:String = UserDefaults.standard.getOldSKU()
        if currentSKU == "" && oldSKU == "" {
            UserDefaults.standard.setOldSKU(value: barcode)
            UserDefaults.standard.setCurrentSKU(value: barcode)
        } else if UserDefaults.standard.getCurrentSKU() != barcode {
            if currentSKU == barcode {
                UserDefaults.standard.setOldSKU(value: barcode)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            } else {
                UserDefaults.standard.setOldSKU(value: currentSKU)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            }
            
        } else if UserDefaults.standard.getCurrentSKU() != "" && UserDefaults.standard.getOldSKU() != "" {
            if currentSKU == barcode {
                UserDefaults.standard.setOldSKU(value: barcode)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            } else {
                UserDefaults.standard.setOldSKU(value: currentSKU)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            }
        } else {
            if currentSKU == barcode {
                UserDefaults.standard.setOldSKU(value: barcode)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            } else {
                UserDefaults.standard.setOldSKU(value: currentSKU)
                UserDefaults.standard.setCurrentSKU(value: barcode)
            }
        }
        Constant.kAppDelegate.barcodeNumber = UserDefaults.standard.getCurrentSKU()
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
        if touch?.view == self.buttonsView || touch?.view == self.tableView || touch?.view == self.headerView {
            hideMenuView()
        }
    }
    
    //uibutton configuration
    func uiButtons() {
        
        btnInqueryLeadingConstrain.constant = Constant.DeviceType.IS_PAD ? 17 : 5
        
        [btnInquery, btnPhoto, btnLocalINV, btnOrderInfo, btnSalesHistory, btnRelatedIntems, btnTBDOne, btnTBDTwo].forEach {
            
            $0.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        }
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.cornerRadius = 5
        buttonsView.layer.borderColor = UIColor.black.cgColor
        
        btnMore.isHidden = true
        lblMoreUndreLine.isHidden = true
        
        btnBack.layer.cornerRadius = btnBack.layer.frame.width * 0.5
        btnBack.isHidden = true
    }
    
    
    func navigationConfig() {
        self.navigationItem.setHidesBackButton(true, animated:true);
        self.navigationController?.isToolbarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // xib configiration
    func registerXib() {
        //register inqury xib
        
        productTableView.register(UINib(nibName: "RatingCell", bundle: nil), forCellReuseIdentifier: "RatingCell")
        
        productTableView.register(UINib(nibName: "Inquiry", bundle: nil), forCellReuseIdentifier: "Inquiry")
        
        productTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        // register Local INv xib
        
        productTableView.register(UINib(nibName: "LocalINV", bundle: nil), forCellReuseIdentifier: "LocalINVCell")
        //SalesHistory xib
        
        productTableView.register(UINib(nibName: "SalesHistory", bundle: nil), forCellReuseIdentifier: "SalesHistory")        // local INV header xib
        
        // Order info xib
        productTableView.register(UINib(nibName: "OrderInfo", bundle: nil), forCellReuseIdentifier: "OrderInfo")
        
        //table2 info xib
        productTableView.register(UINib(nibName: "Table2ViewCell", bundle: nil), forCellReuseIdentifier: "Table2ViewCell")
        
        
        let nibName = UINib(nibName: "LocalINVHeader", bundle: nil)
        self.productTableView.register(nibName, forHeaderFooterViewReuseIdentifier: "LocalINVHeader")
        
        // sales history header xib
        
        let salesHeaderNib = UINib(nibName: "SalesHistoryHeader", bundle: nil)
        self.productTableView.register(salesHeaderNib, forHeaderFooterViewReuseIdentifier: "SalesHistoryHeader")
        
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        
        productTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        
        //Realted Items
        productTableView.register(UINib(nibName: "RelatedTableViewCell", bundle: nil), forCellReuseIdentifier: "RelatedTableViewCell")
        
    }
    
    func moveOnMainScreen(isFromSKU:Bool) {
        let viewController:
            MainViewController = UIStoryboard(
                name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "Main") as! MainViewController
        viewController.isFromSKUClick = isFromSKU
        let NavigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        viewController.navigationController?.isNavigationBarHidden = true
        
        UIApplication.shared.keyWindow?.rootViewController? = NavigationController
    }
    
    // MARK:  Menu item selection
    fileprivate func menuItemSelected(Row num: Int) {
        hideMenuView()
        switch num {
        case 0:
            Constant.kAppDelegate.isBackFromProduct = true
            self.moveOnMainScreen(isFromSKU: false)
            // self.dismiss(animated: true, completion: nil)
            print("Home")
            
        case 1:
            if  UserDefaults.standard.getOldSKU() != "" {
                Constant.kAppDelegate.isOldProductData = true
                self.removeAllArrayData()
                GetProductDetails(barcodeForProduct: UserDefaults.standard.getOldSKU())
            }
            
            print("Profile Info")
            
        default:
            print("Default menu")
        }
    }
}

//MARK:- tableview methods
extension ProductInformationViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if screen == 3 || screen == 5 {
            return 35
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if screen == 3 {
            let headerView = self.productTableView.dequeueReusableHeaderFooterView(withIdentifier: "LocalINVHeader" ) as! LocalINVHeader
            headerView.lblStore.text = "STORE"
            headerView.lblNum.text = "#"
            headerView.lblQty.text = "QTY"
            return headerView
        } else if screen == 5 {
            let headerView = self.productTableView.dequeueReusableHeaderFooterView(withIdentifier: "SalesHistoryHeader" ) as! SalesHistoryHeader
           
            headerView.lblStore.text = singaltan.aubuchon.branchCode.count > 2 ? singaltan.aubuchon.branchCode : "0" + singaltan.aubuchon.branchCode
            headerView.lblCompany.text = "COMPANY"
            return headerView
        } else {
            let headerView = self.productTableView.dequeueReusableHeaderFooterView(withIdentifier: "LocalINVHeader" ) as! LocalINVHeader
            headerView.lblStore.text = ""
            headerView.lblNum.text = ""
            headerView.lblQty.text = ""
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblMenu {
            return menu.count
        } else {
            if screen == 1 {
                isDataFound = objectsArray.count > 0
                return objectsArray.count > 0 ? objectsArray.count + 1 : 0
            } else if screen == 2 {
                isDataFound = true
                return 1
            } else if screen == 3 {
                
                isDataFound = storeStockArray.count > 0
                return storeStockArray.count
                
            } else if screen == 4 {
                //return 6
                isDataFound = onderInfoArray.count > 0
                return onderInfoArray.count  + tableTwoUniqueDataForOrderInfo.count
            } else if screen == 5 {
                // return 7
                isDataFound = salesByMonthArray.count > 0
                return salesByMonthArray.count
            } else if screen == 6 {
                // return storeRelatedProductArray.count
                //isDataFound = true
                isDataFound = storeRelatedProductArray.count > 0
                return 1
            } else if screen == 7 || screen == 8 {
                isDataFound = true
                return 1
            } else {
                isDataFound = inquiryArray.count > 0
                return inquiryArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblMenu {
            let cell = tblMenu.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
            cell.lblMenu.text = menu[indexPath.row]
            return cell
        } else {
            if screen == 1 {
                
                if indexPath.row < objectsArray.count{
                    let cell = productTableView.dequeueReusableCell(withIdentifier: "Inquiry", for: indexPath) as! InquiryCollectionViewCell
                    
                    cell.lblInqueryValues.text = objectsArray[indexPath.row].inqueryValues
                    cell.lblInquryTitle.text = objectsArray[indexPath.row].inqueryTitle
                    
                    cell.inqueryView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.white
                    return cell
                }
                    //Display Rating cell
                else {
                    
                    let cell = productTableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as! RatingCell
                    cell.selectionStyle = .none
                    

                    cell.lblDesc.text = self.objProductOrderInfo?.webDesc
                  
                    cell.lblRate.text = "(\(self.objProductOrderInfo?.rating ?? 0.0))"
                    cell.vwRating.rating = self.objProductOrderInfo?.rating ?? 0.0
                    
                    return cell
                }
            } else if screen == 3 {
                
                let cell = productTableView.dequeueReusableCell(withIdentifier: "LocalINVCell", for: indexPath) as! LocalINVCollectionViewCell
                
                cell.localInvView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.white
                cell.lblSeparator.isHidden = true
                cell.lblWhiteSeparator.isHidden = true
                
                if indexPath.row == sortedNearestStock.count - 1 {
                    cell.lblSeparator.isHidden = false
                    cell.lblWhiteSeparator.isHidden = false
                }
                
                cell.lblStore.text = storeFinalStockArray[indexPath.row].name
                cell.lblNum.text = storeFinalStockArray[indexPath.row].store
                cell.lblQty.text = String(storeFinalStockArray[indexPath.row].qty)
                
                return cell
            }
                //Order Info
            else if screen == 4 {
                if indexPath.row < onderInfoArray.count {
                    let cell = productTableView.dequeueReusableCell(withIdentifier: "OrderInfo", for: indexPath) as! OrderInfoTableViewCell
                    
                    cell.OrderInfoView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.white
                    cell.lblOrderTitle.text = onderInfoArray[indexPath.row].orderInfoTitle
                    cell.lblOrderValue.text = onderInfoArray[indexPath.row].orderInfoValues
                    return cell
                } else {
                    
                    let cell = productTableView.dequeueReusableCell(withIdentifier: "Table2ViewCell", for: indexPath) as! Table2ViewCell
                    
                    cell.tableTwoDataView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.white
                    cell.lblPoTable2Value.text = tableTwoUniqueDataForOrderInfo[indexPath.row - onderInfoArray.count].poNo
                    cell.lblQtyTbale2Value.text = String(tableTwoUniqueDataForOrderInfo[indexPath.row - onderInfoArray.count].orderQty)
//                    cell.lblPoTable2Value.text = tableTwoUniqueDataForOrderInfo[indexPath.row - onderInfoArray.count]
//                    cell.lblQtyTbale2Value.text = String(QtyCheckData[indexPath.row - onderInfoArray.count])
                    return cell
                }
                
            } else if screen == 2  {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
                if screen == 2 {
                    cell.imageData = self.image
                } else {
                    cell.imageData = "related_image"
                    
                }
               
                cell.strProductUrl = self.strProductUrl
                //cell.imageCollectionView.isScrollEnabled = false
                cell.collectionViewHeightConstrain.constant = self.view.frame.size.height
                cell.realodCollectionView()
                return cell
            } else if screen == 5 {
                
                let cell = productTableView.dequeueReusableCell(withIdentifier: "SalesHistory", for: indexPath) as! SalesHistoryCollectionViewCell
                
                cell.salesHistoryView.backgroundColor = indexPath.row % 2 == 0 ? UIColor.gray : UIColor.white
                
                cell.lblMonth.text = (DateFormatter().monthSymbols[salesByMonthArray[indexPath.row].mon - 1]).prefix(3) + " " + String(salesByMonthArray[indexPath.row].yr)
                
                
                cell.lblStoreValue.text = String(salesByMonthArray[indexPath.row].storeQty)
                cell.lblCompanyValue.text = String(salesByMonthArray[indexPath.row].companyQty)
                return cell
                
            } else if screen == 6 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "RelatedTableViewCell", for: indexPath) as! RelatedTableViewCell
                
                cell.productDisplayData = storeRelatedProductArray
                if Constant.kAppDelegate.isReloadRelatedItem == false {
                    cell.realodCollectionView(cellHeight: self.tableView.frame.size.height)
                }
                return cell
            } else if screen == 7 || screen == 8 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
                cell.cellHeightConstrain.constant = UIScreen.main.bounds.size.height
                cell.lblMsg.text = "TBD coming soon"
                
                return cell
            }
            else {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "Inquiry", for: indexPath) as! InquiryCollectionViewCell
                
                cell.lblInqueryValues.text = objectsArray[indexPath.row].inqueryValues
                cell.lblInquryTitle.text = objectsArray[indexPath.row].inqueryTitle
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblMenu {
            return 40
        } else {
            if screen == 7 && screen == 8 {
                return 800
            }else if screen == 1{
                if indexPath.row < objectsArray.count{
                    return 110
                }else{
                    return Constant.DeviceType.IS_PAD ? 190:145 //Rating cell
                }
            }
            else {
                return 110
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if screen == 7 && screen == 8 {
            return 800
        } else if screen == 6 {
            return self.tableView.frame.height
        } else if screen == 4 {
            return 60
        } else if screen == 1 && tableView == productTableView {
            if indexPath.row < objectsArray.count{
                return UITableViewAutomaticDimension
            }else{
                return UITableViewAutomaticDimension//Constant.DeviceType.IS_PAD ? 190:145 //Rating cell
            }
        } else if screen == 2 {
             return self.tableView.frame.height
        }
        else {
            return UITableViewAutomaticDimension
            // return 50
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblMenu {
            // tblMenu.backgroundColor = UIColor.blue
            menuItemSelected(Row: indexPath.row)
        }
    }
    
}

extension UIButton {
    internal func buttonFormator(borderwidth:CGFloat! = nil,borderColor:CGColor! = nil,cornerRadious:CGFloat! = nil) {
        if borderwidth != nil {
            self.layer.borderWidth = borderwidth
        }
        if borderColor != nil {
            self.layer.borderColor = borderColor
        }
        if cornerRadious != nil {
            self.layer.cornerRadius = cornerRadious
        }
    }
}
