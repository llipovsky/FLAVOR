//
//  CustomHomeDesignView.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CustomHomeDesignView: UIView {
    
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowColor : UIColor? = UIColor.white
    
    @IBInspectable var shadowOffsetWidth : Int = 0
    @IBInspectable var shadowOffsetHeight : Int = 0
    
    @IBInspectable var shadowOpacity : Float = 0.1
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        
        layer.shadowOpacity = shadowOpacity
    }
    
}
