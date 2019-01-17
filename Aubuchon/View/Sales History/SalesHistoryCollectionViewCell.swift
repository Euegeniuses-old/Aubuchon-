//
//  SalesHistoryCollectionViewCell.swift
//  Aubuchon
//
//  Created by mac on 11/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class SalesHistoryCollectionViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var salesHistoryView: UIView!
    @IBOutlet weak var lblStoreMonth: UILabel!
    @IBOutlet weak var lblStoreValue: UILabel!
    @IBOutlet weak var lblCompanyMonth: UILabel!
    @IBOutlet weak var lblCompanyValue: UILabel!
    @IBOutlet weak var lblMonth: UILabel!
    
    @IBOutlet weak var lblMonthView: UIView!
    
    @IBOutlet weak var lblStoreView: UIView!
    override func awakeFromNib() {
        self.lblStoreView.addBorder(toEdges: [ .left], color: UIColor.black, thickness: 5)
    }
}
