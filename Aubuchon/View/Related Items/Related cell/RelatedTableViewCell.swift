//
//  RelatedTableViewCell.swift
//  Aubuchon
//
//  Created by mac on 16/01/19.
//  Copyright © 2019 Differenz. All rights reserved.
//

import UIKit
import SDWebImage
class RelatedTableViewCell: UITableViewCell {

    @IBOutlet weak var relatedCollectionView: UICollectionView!
    
    var productDisplayData = [RelatedProduct]()
    var cellHeight:CGFloat?
    override func awakeFromNib() {
        super.awakeFromNib()
        relatedCollectionView.dataSource = self
        relatedCollectionView.delegate = self
        self.relatedCollectionView.register(UINib(nibName: "RelatedItems",
                                                bundle: Bundle.main),
                                          forCellWithReuseIdentifier: "RelatedItems")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //MARK:- reload collectionview
    func realodCollectionView(cellHeight:CGFloat) {
      
        
        Constant.kAppDelegate.isReloadRelatedItem = true
        self.cellHeight = cellHeight
        relatedCollectionView.reloadData()
    }
    
    func getCurrentCelldata(selectedIndex: IndexPath) {
        Constant.kAppDelegate.isReloadRelatedItem = false
        Constant.kAppDelegate.isOldProductData = false
        let currentCellSKU = productDisplayData[selectedIndex.row].sku
        print(currentCellSKU)
        Constant.kAppDelegate.relatedItemCellSku = currentCellSKU
        NotificationCenter.default.post(name: Notification.Name("relatedItemsCelldata"), object: nil,userInfo:nil)
        productDisplayData.removeAll()
    }
    
}
extension RelatedTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
//    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
//        //#warning Incomplete method implementation -- Return the number of sections
//        return 1
//    }
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.width, height: 35)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productDisplayData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : RelatedItemsCollectionViewCell = relatedCollectionView.dequeueReusableCell(withReuseIdentifier: "RelatedItems", for: indexPath) as! RelatedItemsCollectionViewCell
       cell.productName.text = productDisplayData[indexPath.row].webDesc
        cell.productPrice.text =  "$" + String(productDisplayData[indexPath.row].retailPrice)
        if productDisplayData[indexPath.row].image == "" {
             cell.productImage.image = UIImage(named: "camera")
            
        } else {
             cell.productImage.sd_setImage(with: URL(string: productDisplayData[indexPath.row].image), placeholderImage: UIImage(named: "camera"))
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.frame.width, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
       
        self.getCurrentCelldata(selectedIndex: indexPath)
        
    }
    
    
    
    
}
