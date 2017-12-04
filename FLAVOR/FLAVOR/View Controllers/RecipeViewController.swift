//
//  RecipeViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 23/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    

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
    
    @IBOutlet weak var ingredientsView: UIView!
    
    var selectedRecipe : RecipeModel?
    
    
    @IBOutlet weak var instructionTableView: UITableView!
   
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var instructionTableViewHeightConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
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
            var formattedString = ""
            if(string == strings?.last){
                formattedString = "\(bulletPoint) \(string)"
            }
            else {
                formattedString = "\(bulletPoint) \(string)\n"
            }
            fullString = fullString + formattedString
        }
        
        //ingredientsLabel.frame.origin = CGPoint(x: postup.frame.origin.x, y: ingredientsLabel.frame.origin.y)
        //ingredientsLabel.frame = CGRect(x: ingrediencie.frame.origin.x, y: ingrediencie.frame.origin.y + ingrediencie.frame.height, width: ingredientsLabel.frame.width, height: ingredientsLabel.frame.height)
       
        ingredientsLabel.attributedText = highlight(word: "\u{2022}", in: fullString, with: .orange)
        ingredientsLabel.numberOfLines = 0
        ingredientsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        ingredientsLabel.sizeToFit()
       
       // ingredientsView.frame = CGRect(x: ingredientsView.frame.origin.x, y: ingredientsView.frame.origin.y, width: ingredientsView.frame.width, height: ingredientsLabel.frame.size.height)
            
            //)(width: ingredientsView.frame.size.width, height: ingredientsLabel.frame.size.height * 40)
        
        
     
        
       // postup.frame.origin = CGPoint(x: postup.frame.origin.x, y: postup.frame.origin.y + ingredientsLabel.frame.height)
       // instrutionsLabel.frame.origin = CGPoint(x: postup.frame.origin.x, y: postup.frame.origin.y + postup.frame.height)
        
        strings = selectedRecipe?.instructions
        
        fullString = ""
        
        for string: String in strings!
        {
            let bulletPoint: String = "\u{2022}"
            var formattedString = ""
            if(string == strings?.last){
                formattedString = "\(bulletPoint) \(string)"
            }
            else {
                formattedString = "\(bulletPoint) \(string)\n"
            }
            fullString = fullString + formattedString
        }
        
        /*instrutionsLabel.text = fullString
        instrutionsLabel.numberOfLines = 0
        instrutionsLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        instrutionsLabel.sizeToFit()*/
       // postupView.frame.size = CGSize(width: postup.frame.size.width, height: instrutionsLabel.frame.size.height)
        //view.frame.height * 10)
        //scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
       // scrollView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(2000))
        //contentView.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height * 5)
        //contentView.frame.size = CGSize(width: self.view.frame.width, height: CGFloat(2000))
       // contentView.frame.size.height = 2000
        
        //instructionTableView.contentSize = CGSize(width: self.view.frame.width, height: CGFloat(2000))
       // postupView.isHidden = true
        
        
        //// TABLE VIEW
        instructionTableView.rowHeight = UITableViewAutomaticDimension
        instructionTableView.estimatedRowHeight = 90
        
        instructionTableView.delegate = self
        instructionTableView.dataSource = self
        instructionTableView.layoutIfNeeded()
        
        
       // instructionTableView.isScrollEnabled = false;
       
       // self.view.frame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height * 2)
        
        /*scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: scrollView.frame.size.height)
        */
        //scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 300000)
    }

    override func viewDidLayoutSubviews() {
        var tableViewHeight: CGFloat {
            instructionTableView.layoutIfNeeded()
            
            return instructionTableView.contentSize.height
        }
        
        
        
        let viewableTable = instructionTableView.frame.maxY - instructionTableView.frame.origin.y
        let hiddenTable = tableViewHeight - viewableTable
        let scrollViewHeight = CGFloat(scrollView.frame.height + hiddenTable)
       // print(tableViewHeight)
        print("Table Height: \(tableViewHeight)")
        print("View Height: \(self.view.frame.height)")
        print("Scroll Height: \(scrollView.contentSize.height)")
        print("Content Height: \(contentView.frame.size.height)")
       // print("Constraint Height: \(contentViewHeightConstraint.constant)")
        print("Table Start Height: \(instructionTableView.frame.origin.y)")
        print("Table End Height: \(instructionTableView.frame.maxY)")
        print("Hidden Table Height: \(hiddenTable)")
        
        
     
       instructionTableViewHeightConstraint.constant = hiddenTable
        var frame = instructionTableView.frame
        frame.size.height = tableViewHeight
        instructionTableView.frame = frame
        print(self.view.frame.maxY)
        
        //instructionTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: tableViewHeight)
        
        if(hiddenTable > 0) {
        //contentViewHeightConstraint.constant = hiddenTable/10
       // self.view.frame.size.height += hiddenTable
            //contentView.frame.size.height += hiddenTable
            //contentViewBottomConstraint.constant = hiddenTable
           // instructionTableView.frame..height += hiddenTable
            
        }
        // scrollView.contentSize.height = scrollViewHeight
       // instructionTableView.frame = CGRect(x: instructionTableView.frame.origin.x, y: instructionTableView.frame.origin.y, width: instructionTableView.frame.size.width, height: 700)
        
        
    }
    
    
    func highlight(word: String, in str: String, with color: UIColor) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: str)
        let highlightAttributes = [NSAttributedStringKey.foregroundColor: color]
        
        let nsstr = str as NSString
        var searchRange = NSMakeRange(0, nsstr.length)
        
        while true {
            let foundRange = nsstr.range(of: word, options: [], range: searchRange)
            if foundRange.location == NSNotFound {
                break
            }
            
            attributedString.setAttributes(highlightAttributes, range: foundRange)
            
            let newLocation = foundRange.location + foundRange.length
            let newLength = nsstr.length - newLocation
            searchRange = NSMakeRange(newLocation, newLength)
        }
        
        return attributedString
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (selectedRecipe?.instructions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
            let cell = instructionTableView.dequeueReusableCell(withIdentifier: "instructionCell") as! CustomInstructionTableViewCell
        
        cell.number.text = String(indexPath.row + 1)
        cell.instruction.text = selectedRecipe?.instructions![indexPath.row]
    
            return cell
    }
    
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       let cell = instructionTableView.dequeueReusableCell(withIdentifier: "instructionCell", for: indexPath) as! CustomInstructionTableViewCell
        print(cell.frame.height)
        
        return cell.frame.height
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
   */

}
