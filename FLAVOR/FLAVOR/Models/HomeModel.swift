//
//  HomeModel.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 23/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit
import Foundation

protocol HomeModelProtocol: class {
    func itemsDownloaded(items: NSArray)
}


class HomeModel: NSObject, URLSessionDataDelegate {
    
    //properties
    
    weak var delegate: HomeModelProtocol!
    
    var data = Data()
    
    let urlPath: String = "http://bajkalska13a.club/php/exportJSON.php" //this will be changed to the path where service.php lives
    
    func downloadItems() {
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                print("Failed to download data")
            }else {
                print("Data downloaded")
                self.parseJSON(data!)
            }
            
        }
        
        task.resume()
    }
    
    func parseJSON(_ data:Data) {
        
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
        } catch let error as NSError {
            print(error)
            
        }
        
        var jsonElement = NSDictionary()
        let recipes = NSMutableArray()
        
        for i in 0 ..< jsonResult.count
        {
            
            jsonElement = jsonResult[i] as! NSDictionary
            
            let recipe = RecipeModel()
            
            //the following insures none of the JsonElement values are nil through optional binding
            if let id = jsonElement["id"] as? String,
                let name = jsonElement["recipe"] as? String,
                let category = jsonElement["category"] as? String,
                let package = jsonElement["package"] as? String,
                let cooking_time = jsonElement["cooking_time"] as? String,
                let difficulty = jsonElement["difficulty"] as? String,
                let serving = jsonElement["serving"] as? String
            {
                recipe.id = id
                recipe.name = name
                recipe.category = category
                recipe.package = package
                recipe.cooking_time = cooking_time
                recipe.difficulty = difficulty
                recipe.serving = serving
                
            }
            
            recipes.add(recipe)
            
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.delegate.itemsDownloaded(items: recipes)
            
        })
    }
}
