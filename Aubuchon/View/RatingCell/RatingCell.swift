//
//  RatingCell.swift
//  Aubuchon
//
//  Created by mac on 23/01/19.
//  Copyright © 2019 Differenz. All rights reserved.
//

import UIKit
import Cosmos


class RatingCell: UITableViewCell {

    @IBOutlet weak var lblSeperator: UILabel!
    @IBOutlet weak var lblProductRating: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var vwRating: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vwRating.settings.starSize = Constant.DeviceType.IS_PAD ? 45 : 30
        vwRating.settings.fillMode = .precise
        vwRating.settings.filledColor = UIColor.darkGray
        vwRating.settings.emptyColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
