//
//  FavouritesTableViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit
import CoreData

class FavouritesTableViewController: UITableViewController {

    var feedItems: NSArray = NSArray()
    var myFavRecipes: [RecipeModel] = [RecipeModel]()
     var selectedRecipe : RecipeModel = RecipeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.register(UINib(nibName: "CustomRecipeBlockCell", bundle: nil), forCellReuseIdentifier: "RecipeBlockCell")
       // navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // navigationController?.navigationBar.prefersLargeTitles = true
        
        if feedItems.count > 0 {
            myFavRecipes.removeAll()
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            // Check if it is already favourite
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
            
            let result = try? managedContext.fetch(fetchRequest)
            let resultData = result as! [FavRecipe]
            
            for object in resultData {
                for element in feedItems {
                    let feedItem = element as! RecipeModel
                    if Int(feedItem.id!)! == object.id {
                        myFavRecipes.append(feedItem)
                    }
                }
            }
            
            //3
           
            /*do {
                let recipe = try managedContext.fetch(fetchRequest)
                
                
                myFavRecipes.append(recipe)
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            */
           // categories = Array(Set(categories))
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
        return myFavRecipes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeBlockCell", for: indexPath) as! CustomRecipeBlockCell
        
        let item: RecipeModel = myFavRecipes[indexPath.row]
        
        cell.mainImage.image = UIImage(named: "Pasta Salad")
        cell.nameLabel.text = item.name
        cell.categoryLabel.text = item.category
        cell.difficultyLabel.text = item.difficulty
        cell.minutesLabel.text = item.cooking_time
        cell.peopleLabel.text = item.serving
        
        /*
        cell.contentView.backgroundColor = UIColor(hexString: "F7F7F7")
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = bgColorView
        */
        return cell
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

    
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
     selectedRecipe = myFavRecipes[indexPath.row]
     self.performSegue(withIdentifier: "favouriteToRecipeSegue", sender: self)
     
     
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
