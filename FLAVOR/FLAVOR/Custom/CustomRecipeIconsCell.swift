//
//  CustomRecipeIconsCell.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/12/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomRecipeIconsCell: UITableViewCell {

    @IBOutlet weak var timeImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var servingsImage: UIImageView!
    @IBOutlet weak var servingsLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
