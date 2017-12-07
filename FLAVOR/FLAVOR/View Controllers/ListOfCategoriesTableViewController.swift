//
//  ListOfCategoriesTableViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 07/12/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class ListOfCategoriesTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    var feedItems: NSArray = NSArray()
    var categoryRecipes : [RecipeModel]?// = [RecipeModel]()
    var selectedCategory : String?
    var selectedRecipe : RecipeModel = RecipeModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "CustomFullWidthImageCell", bundle: nil), forCellReuseIdentifier: "fullWidthImageCell")
        tableView.register(UINib(nibName: "CustomRecipeBlockCell", bundle: nil), forCellReuseIdentifier: "RecipeBlockCell")
        
        
        //create a new button
        let backButton: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        backButton.setImage(UIImage(named: "ic_arrow_back_white"), for: UIControlState.normal)
        //add function for button
        backButton.addTarget(self, action: #selector(backToPreviousView(_:)), for: UIControlEvents.touchUpInside)
        //set frame
        let backBarButton = UIBarButtonItem(customView: backButton)
        //assign button to navigationbar
        self.navigationItem.leftBarButtonItem = backBarButton
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        
    }

    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            return true
        }
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    @objc func backToPreviousView(_ button: UIButton) {
        _ = navigationController?.popViewController(animated: true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4 + (categoryRecipes?.count)!
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
             let cell = tableView.dequeueReusableCell(withIdentifier: "fullWidthImageCell", for: indexPath) as! CustomFullWidthImageCell
            cell.mainImage.image = UIImage(named: "categoryListMainImage")
            return cell;
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categorySectionTitleCell", for: indexPath)
            return cell;
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTitleCell", for: indexPath) as! CustomListCategoryTitleCell
            cell.label.text = selectedCategory
            return cell;
        }
        else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryRecipesCountCell", for: indexPath) as! CustomListCategoryCountCell
            let recipeCount = categoryRecipes!.count
            cell.label.text = "\(recipeCount) Recipes"
            return cell;
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBlockCell", for: indexPath) as! CustomRecipeBlockCell
            
            let item: RecipeModel = categoryRecipes![indexPath.row - 4]
            
            cell.mainImage.image = UIImage(named: "Pasta Salad")
            cell.nameLabel.text = item.name
            cell.categoryLabel.text = item.category
            cell.difficultyLabel.text = item.difficulty
            cell.minutesLabel.text = item.cooking_time
            cell.peopleLabel.text = item.serving
            
            
            cell.contentView.backgroundColor = UIColor(hexString: "F7F7F7")
            
            let bgColorView = UIView()
            bgColorView.backgroundColor = UIColor.white
            cell.selectedBackgroundView = bgColorView
 
            return cell
        }
        
        //categoryRecipesCountCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

  //      return cell
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if(indexPath.row < 4){
            return self.tableView.rowHeight
        }
        else {
            return 258.0
        }
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Set selected location to var
        if(indexPath.row < 4) {
            return
        }
        else {
            selectedRecipe = categoryRecipes![indexPath.row - 4]
            self.performSegue(withIdentifier: "categoryToRecipeSegue", sender: self)
        }
        
        // Manually call segue to detail view controller
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! RecipeTableViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.selectedRecipe = selectedRecipe
        
    }

}
