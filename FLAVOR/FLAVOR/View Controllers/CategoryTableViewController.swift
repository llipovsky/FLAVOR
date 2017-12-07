//
//  CategoryTableViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController{

    var feedItems: NSArray = NSArray()
    var categories: [String] = [String]()
    var allCategoryRecipes: [RecipeModel] = [RecipeModel]()
    var selectedCategory : String = String()
    
    // Properties
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
            if feedItems.count > 0 {
                for item in feedItems {
                    let recipe = item as! RecipeModel
                    categories.append(recipe.category!)
                }
                
                categories = Array(Set(categories))
                tableView.reloadData()
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
       /* if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryTitleCell", for: indexPath) as! CustomCategoryTitleCell
            //cell.label.text = categories[indexPath.row]
            return cell
          
        }*/
       // else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CustomCategoryCell
            cell.label.text = categories[indexPath.row ]
            return cell
        //}
       
        // Configure the cell...
        
       
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
       
            selectedCategory = categories[indexPath.row ]
            self.performSegue(withIdentifier: "categorySegue", sender: self)
        
        
        // Manually call segue to detail view controller
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get reference to the destination view controller
        let detailVC  = segue.destination as! ListOfCategoriesTableViewController
        // Set the property to the selected location so when the view for
        // detail view controller loads, it can access that property to get the feeditem obj
        detailVC.feedItems = feedItems
        detailVC.selectedCategory = selectedCategory
        // Get All the recipes from sleected category
        for item in feedItems {
            let recipe: RecipeModel = item as! RecipeModel
            if recipe.category == selectedCategory {
                allCategoryRecipes.append(recipe)
            }
        }
        
        detailVC.categoryRecipes = allCategoryRecipes
        //selectedCategory = ""
        allCategoryRecipes.removeAll()
        
    }

}
