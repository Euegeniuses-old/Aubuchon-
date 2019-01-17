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
    
    // Variable
    var imageData:String = ""
    
    //Mark:- Initializ code
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
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
        }
//        else if imageData == "related_image" {
//                cell.imgProduct.image = UIImage(named: imageData)
//        }
        else {
            cell.imgProduct.sd_setImage(with: URL(string: imageData), placeholderImage: UIImage(named: "camera"))
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: self.frame.height)
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


