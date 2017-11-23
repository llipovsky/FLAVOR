//
//  RecipeModel.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 23/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit
import Foundation

class RecipeModel: NSObject {
    
    // parameters
    var id: String?
    var name: String?
    var category: String?
    var package: String?
    var cooking_time: String?
    var difficulty: String?
    var serving: String?
    var ingredients: [String]?
    var instructions: [String]?
    
    override init() {
        
    }

    init(id: String, name: String, category: String, package: String, cooking_time: String, difficulty: String, serving: String) {
        self.id = id
        self.name = name
        self.category = category
        self.package = package
        self.cooking_time = cooking_time
        self.difficulty = difficulty
        self.serving = serving
    }
    
    override var description: String {
        return "Name: \(name), Category: \(category), Package: \(package), Cooking Time: \(cooking_time), Difficulty: \(difficulty), Serving: \(serving)"
    }
}
