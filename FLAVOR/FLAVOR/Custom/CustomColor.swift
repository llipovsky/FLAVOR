//
//  CustomColor.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import Foundation
import Chameleon

struct CustomColor{
    
    let orange: UIColor!
    
    init(withFrame: CGRect) {
        let firstColor =  UIColor(hexString: "FF8C28", withAlpha: 1.0)
        let secondColor =  UIColor(hexString: "FF6322", withAlpha: 1.0)
        
        self.orange = GradientColor(.leftToRight, frame: withFrame, colors: [firstColor!,secondColor!])
    }
    
    // Gets the orange color
    func getOrangeColor() -> UIColor {
        return orange
    }
}
