//
//  ReviewTableViewCell.swift
//  Aubuchon
//
//  Created by mac on 07/01/19.
//  Copyright © 2019 Differenz. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var cellHeightConstrain: NSLayoutConstraint!
    @IBOutlet weak var lblMsg: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
