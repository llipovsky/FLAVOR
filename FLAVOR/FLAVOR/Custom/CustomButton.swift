//
//  CustomButton.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    // first loading function
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
        }
    
    // first required loading func
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        defaultSetup()
    }
    
    // customize the button to
    // orange background color
    func defaultSetup() {
        let orange = CustomColor(withFrame: frame).getOrangeColor()
        
        layer.backgroundColor = orange.cgColor
        layer.cornerRadius = layer.frame.height/2
        layer.masksToBounds = true
        
        makeSpacing(newSpacing: 1.5)
    }
    
    func makeCustomWhiteButton() {
        
        let orange = CustomColor(withFrame: frame).getOrangeColor()
  
        layer.borderWidth = 2
        layer.backgroundColor = UIColor.white.cgColor
        layer.borderColor = orange.cgColor
        //layer.cornerRadius = layer.frame.height/2
        titleLabel?.textColor = orange
        layer.masksToBounds = true
    }
    
    func makeSpacing(newSpacing: Float) {
       
        let buttonAttributedString = NSMutableAttributedString(string: (titleLabel?.text)!)
        buttonAttributedString.addAttribute(NSAttributedStringKey.kern, value: newSpacing, range: NSMakeRange(0, buttonAttributedString.length))
        
        self.setAttributedTitle(buttonAttributedString, for: .normal)
    }
}


