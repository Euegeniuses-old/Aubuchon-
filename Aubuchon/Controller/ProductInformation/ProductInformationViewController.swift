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
class ProductInformationViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var btnInquery: UIButton!
    @IBOutlet weak var btnPhoto: UIButton!
    @IBOutlet weak var btnLocalINV: UIButton!
    @IBOutlet weak var btnOrderInfo: UIButton!
    @IBOutlet weak var btnSalesHistory: UIButton!
    @IBOutlet weak var btnRelatedIntems: UIButton!
    @IBOutlet weak var btnTBDOne: UIButton!
    @IBOutlet weak var btnTBDTwo: UIButton!
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
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var btnInqueryLeadingConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var lblMoreUndreLine: UILabel!
    @IBOutlet weak var btnMore: UIButton!
    // Variables
    var barcode : String = ""
    var screen : Int = 1
    var productData = [ImageUpload]()
    var image:String = ""
    var inquiryArray : [String] = ["Item Number","Desc","Price","Promo","OH","Available","Section","Speed#"]
    // var inquiryValue : [String] = ["129991","Pellet Green Supreme","6.99","50/259.99","250.00","250.00","F030-002F","10"]
    //    var inquiryArray:[String] = []
    var inquiryValue:[String] = []
    var inqueryData : [String:Any] = [:]
    var objectsArray = [Objects]()
    var localNVStore : [String] = ["Gardner","Lunenburg","Littleton","Keene","Winchester","Walpole","Lunenburg"]
    var localINVNum : [String] = ["004","069","065","030","101","044","069"]
    var localINVQty : [String] = ["1877","0012","0001","1585","1001","9988","0012"]
    
    var orderInfoList : [String] = ["Last Sold","Qty on Order","PO Number","Primary Vender","Vendor #","Delivery date"]
    var orderInfoValue : [String] = ["09/26/18","1500.00","123456789","Lignetics of NE","9961","11/30/18"]
    
    var salesHistoryMonths : [String] = ["Nov","Oct","Sep","Aug","Jul","Dec 2017","Jan 2017"]
    var salesHistoryStoreValue : [String] = ["250","122","036","002","000","800","878"]
    var salesHistoryCompanyValue : [String] = ["5000","1220","0840","0098","0006","8999","9799"]
    
    var menu : [String] = ["Home","Product Info"]
    var isMenuVisible : Bool = false
    var dataforInquery:String = ""
    var storeStockArray = [StoreStock]()
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screen = 1
        btnInquery.backgroundColor = UIColor.black
        btnInquery.setTitleColor(.white, for: .normal)
        
        menuView.layer.borderColor = UIColor.black.cgColor
        menuView.layer.borderWidth = 1
        
        tableView.layer.borderColor = UIColor.black.cgColor
        tableView.layer.borderWidth = 1
        tableView.layer.cornerRadius = 10
        
        navigationConfig()
        hideMenuView()
        registerXib()
        uiButtons()
        objectsArray.removeAll()
        storeStockArray.removeAll()
        fetchProductInfo(barcodeForProduct: barcode)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //barcode = UserDefaults.standard.getCurrentSKU()
        if barcode != "" {
            lblSKU.text = "SKU:\(barcode)"
        } else {
            lblSKU.text = ""
        }
        
    }
    
    //MARK:- Product API call
    func fetchProductInfo(barcodeForProduct:String) {
        ImageUpload.displayProductInfo(with: 156, data: barcodeForProduct, success: { (response, isSuccess,localINV) in
            print(response.count)
            self.inqueryData = response
            if response.count != 0 {
                if Constant.kAppDelegate.isOldProductData != true {
                    self.storeDataInUserDefault()
                }
                for (key, value) in response   {
                    
                    //self.inquiryArray.append(key)
                    //self.inquiryValue.append(self.inqueryData[key] as? String ?? "")
                    
                    if key as? String ?? "" == "imageURL" {
                        self.image = (value as? String)!
                    }
                    
                    //else {
                    //                        self.objectsArray.append(Objects(inqueryTitle: key , inqueryValues: value as? String ?? "0"))
                    //                    }
                    if key as? String ?? "" == "sku" {
                        
                        self.objectsArray.append(Objects(inqueryTitle: "Item Number" , inqueryValues: value as? String ?? "-",id:1))
                        
                        
                    } else if key as? String ?? "" == "webDesc" {
                        self.btnMore.isHidden = false
                        self.lblMoreUndreLine.isHidden = false
                        var desc = value as? String
                        self.lblDesc.text = "DESC:" + desc!
                        self.objectsArray.append(Objects(inqueryTitle: "Desc" , inqueryValues: value as? String ?? "-",id:2))
                        
                    } else if key as? String ?? "" == "retailPrice" {
                        var Price = value as! Double
                        self.dataforInquery = String(Price)
                        self.objectsArray.append(Objects(inqueryTitle: "Price" , inqueryValues: self.dataforInquery ?? "-",id:3))
                        
                    } else if key as? String ?? "" == "promoPrice" {
                        self.objectsArray.append(Objects(inqueryTitle: "promo" , inqueryValues: value as? String ?? "-",id:3))
                    } else if key as? String ?? "" == "onHandAmt" {
                        var onHandAmtdata = value as! Int
                        self.dataforInquery = String(onHandAmtdata)
                        self.objectsArray.append(Objects(inqueryTitle: "OH" , inqueryValues: self.dataforInquery ?? "-",id:4))
                    } else if key as? String ?? "" == "available" {
                        var availableData =  value as! Int
                        self.dataforInquery = String(availableData)
                        self.objectsArray.append(Objects(inqueryTitle: "Available" , inqueryValues:self.dataforInquery ?? "-",id:5))
                    } else if key as? String ?? "" == "section" {
                        self.objectsArray.append(Objects(inqueryTitle: "Section" , inqueryValues: value as? String ?? "-",id:6))
                    } else if key as? String ?? "" == "speedNo" {
                        self.objectsArray.append(Objects(inqueryTitle: "Speed#" , inqueryValues: value as? String ?? "-",id:7))
                        
                    }
                }
                self.storeStockArray = localINV
                print(self.storeStockArray.count)

                
                self.objectsArray.sort(by: { $0.id < $1.id })
                self.productTableView.reloadData()
            } else {
                // UserDefaults.standard.setCurrentSKU(value: "")
                DispatchQueue.main.async {
                    UserDefaults.standard.setOldSKU(value: UserDefaults.standard.getCurrentSKU())
                    let alert = UIAlertController(title: "", message: Constant.alertTitleMessage.validBarcode, preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                        Constant.kAppDelegate.isBackFromProduct = true
                        //self.dismiss(animated: false, completion: nil)
                        self.moveOnMainScreen()
                        
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }) { (response, issuccess) in
            print(response)
            if response == Constant.alertTitleMessage.validBarcode {
                DispatchQueue.main.async {
                    UserDefaults.standard.setOldSKU(value: UserDefaults.standard.getCurrentSKU())
                    let alert = UIAlertController(title: "", message: response, preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
                        Constant.kAppDelegate.isBackFromProduct = true
                        // self.dismiss(animated: false, completion: nil)
                        self.moveOnMainScreen()
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                self.alertMessage(message: response, title: "")
            }
        }
    }
    
    //MARK:- Button actions
    
    //btninquery action
    @IBAction func btnInquiry_Action(_ sender: Any) {
        screen = 1
        buttonColorFormattor(button: btnInquery)
//        objectsArray.removeAll()
//        storeStockArray.removeAll()
//        fetchProductInfo(barcodeForProduct: barcode)
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
            objectsArray.removeAll()
            storeStockArray.removeAll()
            fetchProductInfo(barcodeForProduct: barcode)
        }
    }
    
    
    
    //MARK:- Private functions
    
    // Open  MTBScanner
    func openMTBScanner() {
        let  ScannerVC:
            ScannerViewController = UIStoryboard(
                name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "ScannerView") as! ScannerViewController
        ScannerVC.isFromMain = false
        self.present(ScannerVC, animated: false, completion: nil)
    }
    
    fileprivate func buttonColorFormattor(button:UIButton) {
        if button == btnInquery {
            btnInquery.backgroundColor = UIColor.black
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.setTitleColor(.black, for: .normal)
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
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.backgroundColor = UIColor.white
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
            btnPhoto.backgroundColor = UIColor.white
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
        var currentSKU:String = UserDefaults.standard.getCurrentSKU()
        var oldSKU:String = UserDefaults.standard.getOldSKU()
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
        
        btnInquery.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnPhoto.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnLocalINV.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnOrderInfo.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnSalesHistory.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnRelatedIntems.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnTBDOne.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        btnTBDTwo.buttonFormator(borderwidth: 1.0, borderColor: UIColor.black.cgColor, cornerRadious: 5)
        
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.cornerRadius = 5
        buttonsView.layer.borderColor = UIColor.black.cgColor
        
        btnMore.isHidden = true
        lblMoreUndreLine.isHidden = true
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
        
        productTableView.register(UINib(nibName: "Inquiry", bundle: nil), forCellReuseIdentifier: "Inquiry")
        
        //
        productTableView.register(UINib(nibName: "PhotoTableViewCell", bundle: nil), forCellReuseIdentifier: "PhotoTableViewCell")
        // register Local INv xib
        
        productTableView.register(UINib(nibName: "LocalINV", bundle: nil), forCellReuseIdentifier: "LocalINVCell")
        //SalesHistory xib
        
        productTableView.register(UINib(nibName: "SalesHistory", bundle: nil), forCellReuseIdentifier: "SalesHistory")        // local INV header xib
        
        // Order info xib
        productTableView.register(UINib(nibName: "OrderInfo", bundle: nil), forCellReuseIdentifier: "OrderInfo")
        
        let nibName = UINib(nibName: "LocalINVHeader", bundle: nil)
        self.productTableView.register(nibName, forHeaderFooterViewReuseIdentifier: "LocalINVHeader")
        
        // sales history header xib
        
        let salesHeaderNib = UINib(nibName: "SalesHistoryHeader", bundle: nil)
        self.productTableView.register(salesHeaderNib, forHeaderFooterViewReuseIdentifier: "SalesHistoryHeader")
        
        tblMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        
        
        productTableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        
        
    }
    
    func moveOnMainScreen() {
        let viewController:
            MainViewController = UIStoryboard(
                name: "Main", bundle: nil
                ).instantiateViewController(withIdentifier: "Main") as! MainViewController
        let NavigationController = UINavigationController(rootViewController: viewController)
        viewController.navigationController?.setNavigationBarHidden(true, animated: false)
        viewController.navigationController?.isNavigationBarHidden = true
        
        UIApplication.shared.keyWindow?.rootViewController? = NavigationController
        
    }
    
    // MARK:  Menu item selection
    fileprivate func menuItemSelected(Row num: Int){
        hideMenuView()
        switch num {
        case 0:
            Constant.kAppDelegate.isBackFromProduct = true
            self.moveOnMainScreen()
            // self.dismiss(animated: true, completion: nil)
            print("Home")
            
        case 1:
            if  UserDefaults.standard.getOldSKU() != "" {
                //barcodata = UserDefaults.standard.getOldSKU()
                Constant.kAppDelegate.isOldProductData = true
                
                lblSKU.text = ("SKU:\(UserDefaults.standard.getOldSKU())")
                objectsArray.removeAll()
                storeStockArray.removeAll()
                fetchProductInfo(barcodeForProduct: UserDefaults.standard.getOldSKU())
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
            headerView.lblNum.text = "NUM"
            headerView.lblQty.text = "QTY"
            return headerView
        } else if screen == 5 {
            let headerView = self.productTableView.dequeueReusableHeaderFooterView(withIdentifier: "SalesHistoryHeader" ) as! SalesHistoryHeader
            headerView.lblStore.text = "STORE 170"
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
                return objectsArray.count
                //  return productData.count
                // return inquiryValue.count
                // return inquiryArray.count
            } else if screen == 2 {
                return 1
            } else if screen == 3 {
                //return 7
                return storeStockArray.count
            } else if screen == 4 {
                return 6
            } else if screen == 5 {
                return 7
            } else if screen == 6 {
                return 1
            } else if screen == 7 || screen == 8 {
                return 1
            } else {
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
                let cell = productTableView.dequeueReusableCell(withIdentifier: "Inquiry", for: indexPath) as! InquiryCollectionViewCell
                
                cell.lblInqueryValues.text = objectsArray[indexPath.row].inqueryValues
                cell.lblInquryTitle.text = objectsArray[indexPath.row].inqueryTitle
                //                                cell.lblInqueryValues.text = inquiryValue[indexPath.row]
                //                                cell.lblInquryTitle.text = inquiryValue[indexPath.row]
                if indexPath.row % 2 == 0 {
                    cell.inqueryView.backgroundColor = UIColor.gray
                } else {
                    cell.inqueryView.backgroundColor = UIColor.white
                }
                return cell
                
            } else if screen == 3 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "LocalINVCell", for: indexPath) as! LocalINVCollectionViewCell
                if indexPath.row % 2 == 0 {
                    cell.localInvView.backgroundColor = UIColor.gray
                } else {
                    cell.localInvView.backgroundColor = UIColor.white
                }
                cell.lblStore.text = storeStockArray[indexPath.row].name
                cell.lblNum.text = storeStockArray[indexPath.row].store
                cell.lblQty.text = String(storeStockArray[indexPath.row].qty)

//                cell.lblStore.text = localNVStore[indexPath.row]
//                cell.lblNum.text = localINVNum[indexPath.row]
//                cell.lblQty.text = localINVQty[indexPath.row]
                return cell
            } else if screen == 4 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "OrderInfo", for: indexPath) as! OrderInfoTableViewCell
                if indexPath.row % 2 == 0 {
                    cell.OrderInfoView.backgroundColor = UIColor.gray
                } else {
                    cell.OrderInfoView.backgroundColor = UIColor.white
                }
                cell.lblOrderTitle.text = orderInfoList[indexPath.row]
                cell.lblOrderValue.text = orderInfoValue[indexPath.row]
                return cell
            } else if screen == 2  || screen == 6 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
                if screen == 2 {
                    cell.imageData = self.image
                } else {
                    cell.imageData = "related_image"
                    // cell.imageData = self.image
                }
                //                cell.imageData = self.image
                cell.realodCollectionView()
                return cell
            } else if screen == 5 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "SalesHistory", for: indexPath) as! SalesHistoryCollectionViewCell
                if indexPath.row % 2 == 0 {
                    cell.salesHistoryView.backgroundColor = UIColor.gray
                } else {
                    cell.salesHistoryView.backgroundColor = UIColor.white
                }
                cell.lblStoreMonth.text = salesHistoryMonths[indexPath.row]
                cell.lblStoreValue.text = salesHistoryStoreValue[indexPath.row]
                cell.lblCompanyMonth.text = salesHistoryMonths[indexPath.row]
                cell.lblCompanyValue.text = salesHistoryCompanyValue[indexPath.row]
                return cell
                
            } else if screen == 7 || screen == 8 {
                let cell = productTableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell", for: indexPath) as! ReviewTableViewCell
                cell.cellHeightConstrain.constant = UIScreen.main.bounds.size.height
                if screen == 7 {
                    cell.lblMsg.text = "Review coming soon"
                } else {
                    cell.lblMsg.text = "TBD coming soon"
                }
                
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
            } else {
                return 70
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if screen == 7 && screen == 8 {
            return 800
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblMenu {
            // tblMenu.backgroundColor = UIColor.blue
            menuItemSelected(Row: indexPath.row)
        }
    }
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        if screen == 7 && screen == 8 {
            return UIScreen.main.bounds.size.height
        } else {
            return 70
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
