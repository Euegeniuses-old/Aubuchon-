//
//  Table2ViewCell.swift
//  Aubuchon
//
//  Created by mac on 24/01/19.
//  Copyright © 2019 Differenz. All rights reserved.
//

import UIKit

class Table2ViewCell: UITableViewCell {

    //Outlets
    @IBOutlet weak var lblPoTable2Data: UILabel!
    @IBOutlet weak var lblQtyTable2Data: UILabel!
    @IBOutlet weak var lblPoTable2Value: UILabel!
    @IBOutlet weak var lblQtyTbale2Value: UILabel!
    @IBOutlet weak var tableTwoDataView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
