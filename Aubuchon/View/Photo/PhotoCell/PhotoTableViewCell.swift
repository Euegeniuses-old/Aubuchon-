//
//  PhotoTableViewCell.swift
//  Aubuchon
//
//  Created by mac on 17/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit
import SDWebImage



class PhotoTableViewCell: UITableViewCell {
    
    //Outlet
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightConstrain: NSLayoutConstraint!
    // Variable
    var imageData:String = ""
    var strProductUrl:String = ""
    
    //Mark:- Initializ code
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        imageCollectionView.scrollsToTop = true
        imageCollectionView.isScrollEnabled = false
        self.imageCollectionView.register(UINib(nibName: "Photo",
                                                bundle: Bundle.main),
                                          forCellWithReuseIdentifier: "Photo")
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK:- reload collectionview
    func realodCollectionView() {
        imageCollectionView.reloadData()
        imageCollectionView.scrollsToTop = true
    }
    
    @objc func openWebsite(_ sender:UIButton){
        if let url = URL(string: self.strProductUrl) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(url)
            }
        } else {
            //self.alertMessage(message: "Product detail page not found", title: "")
        }
    }
}

//MARK:- collectionview methods
extension PhotoTableViewCell: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : PhotoCollectionViewCell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "Photo", for: indexPath) as! PhotoCollectionViewCell
       
        if imageData == "" {
                cell.imgProduct.image = UIImage(named: "camera")
        } else {
            cell.imgProduct.sd_setImage(with: URL(string: imageData), placeholderImage: UIImage(named: "camera"))
        }
    
        cell.btnOpenWebsite.addTarget(self, action:#selector(openWebsite(_:)), for: .touchUpInside)
        cell.contentView.isUserInteractionEnabled = false
       
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       // return CGSize(width: self.frame.width, height: self.frame.height)
         return CGSize(width: self.layer.frame.size.width, height: self.layer.frame.size.height)
    }
    
    //MARK:- Scrollview Method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = scrollView.frame.size.width
        let page: CGFloat = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
    }
    
}


