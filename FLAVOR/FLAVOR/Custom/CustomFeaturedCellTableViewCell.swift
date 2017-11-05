//
//  CustomFeaturedCellTableViewCell.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomFeaturedCellTableViewCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    var featuredImages = [UIImageView]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var contentWidth : CGFloat = 0.0
        //self.backgroundColor = UIColor(hexString: "F7F7F7")
        
        for x in 1...3 {
            let image = UIImage(named: "featured\(x).png")
            let imageView = UIImageView(image: image)
            featuredImages.append(imageView)
            
            //var newX : CGFloat = 0.0
           // print(x)
            //newX = scrollView.frame.size.width / 2 + scrollView.frame.size.width * CGFloat(x)
            scrollView.addSubview(imageView)
            
            
            let posX = CGFloat(230 * (x - 1))
            contentWidth += posX
            imageView.frame = CGRect(x: posX, y: 0, width: 208, height: 128)
            imageView.layer.cornerRadius = 8.0
        }
        //print(featuredImages.count)
        
        scrollView.clipsToBounds = false
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.size.height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
