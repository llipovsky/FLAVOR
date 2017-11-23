//
//  RecipeViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 23/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var difficulty: UILabel!
    @IBOutlet weak var serving: UILabel!
    
    @IBOutlet weak var ingrediencie: UILabel!
    @IBOutlet weak var postup: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    
    @IBOutlet weak var instrutionsLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var selectedRecipe : RecipeModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height * 2)
        scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        image.image = UIImage(named: "Pancakes")
        recipeName.text = selectedRecipe?.name
        category.text = selectedRecipe?.category
        time.text = selectedRecipe?.cooking_time
        difficulty.text = selectedRecipe?.difficulty
        serving.text = selectedRecipe?.serving
        
        ////// testy
        var strings = selectedRecipe?.ingredients
        
        var fullString = ""
        
        for string: String in strings!
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            
            fullString = fullString + formattedString
        }
        
        //ingredientsLabel.frame.origin = CGPoint(x: postup.frame.origin.x, y: ingredientsLabel.frame.origin.y)
        //ingredientsLabel.frame = CGRect(x: ingrediencie.frame.origin.x, y: ingrediencie.frame.origin.y + ingrediencie.frame.height, width: ingredientsLabel.frame.width, height: ingredientsLabel.frame.height)
       
        ingredientsLabel.text = fullString + "\n"
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        ingredientsLabel.sizeToFit()
        
        
     
        
        postup.frame.origin = CGPoint(x: postup.frame.origin.x, y: postup.frame.origin.y + ingredientsLabel.frame.height)
        instrutionsLabel.frame.origin = CGPoint(x: postup.frame.origin.x, y: postup.frame.origin.y + postup.frame.height)
        
        strings = selectedRecipe?.instructions
        
         fullString = ""
        
        for string: String in strings!
        {
            let bulletPoint: String = "\u{2022}"
            let formattedString: String = "\(bulletPoint) \(string)\n"
            
            fullString = fullString + formattedString
        }
        
        instrutionsLabel.text = fullString + "\n"
        instrutionsLabel.numberOfLines = 0
        instrutionsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        instrutionsLabel.sizeToFit()
        
        
        
       
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
