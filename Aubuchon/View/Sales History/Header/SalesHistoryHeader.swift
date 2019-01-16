//
//  SalesHistoryHeader.swift
//  Aubuchon
//
//  Created by mac on 11/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class SalesHistoryHeader: UITableViewHeaderFooterView {
    
    //Outlets
    @IBOutlet weak var salesHeaderView: UIView!
    @IBOutlet weak var lblStore: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    
    @IBOutlet weak var monthView: UIView!
    override func awakeFromNib() {
//        monthView.layer.borderWidth = 1
//        monthView.layer.borderColor = UIColor.black.cgColor
      //  monthView.addBorder(toEdges: [ .top], color: UIColor.black, thickness: 1)
    }
}
