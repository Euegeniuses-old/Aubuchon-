//
//  MenuTableViewCell.swift
//  Aubuchon
//
//  Created by mac on 18/12/18.
//  Copyright © 2018 Differenz. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var lblMenu: UILabel!
    @IBOutlet weak var menuView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
