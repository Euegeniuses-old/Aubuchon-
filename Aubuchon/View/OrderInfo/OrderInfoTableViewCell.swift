//
//  OrderInfoTableViewCell.swift
//  Aubuchon
//
//  Created by mac on 17/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class OrderInfoTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var OrderInfoView: UIView!
    @IBOutlet weak var lblOrderTitle: UILabel!
    @IBOutlet weak var lblOrderValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
