//
//  CustomRecipeIngredientsCell.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/12/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomRecipeIngredientsCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let orange = UIColor.init(hexString: "FF8C2B")!
        
        numberLabel.layer.backgroundColor  = orange.cgColor
        numberLabel.textColor = orange
        numberLabel.layer.masksToBounds = true
        numberLabel.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
