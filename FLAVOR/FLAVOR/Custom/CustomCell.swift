//
//  CustomCell.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var peopleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
