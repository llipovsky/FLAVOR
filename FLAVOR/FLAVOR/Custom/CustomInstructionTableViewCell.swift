//
//  CustomInstructionTableViewCell.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 03/12/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomInstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var instruction: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        number.layer.backgroundColor  = UIColor.orange.cgColor
        number.textColor = UIColor.white
        number.layer.masksToBounds = true
        number.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
