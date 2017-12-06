//
//  HomeTableViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 04/11/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController, HomeModelProtocol, UITabBarControllerDelegate{
   
    let images = ["Pasta Salad","Pancakes", "Sour Cream Meat Tacos"]
    var feedItems: NSArray = NSArray()
    var selectedRecipe : RecipeModel = RecipeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        tableView.separatorColor = UIColor(hexString: "F7F7F7")
        tableView.backgroundColor = UIColor(hexString: "F7F7F7")
        
        let homeModel = HomeModel()
        homeModel.delegate = self
        homeModel.downloadItems()
        
        //self.tabBarController?.delegate = self
    }
    // HomeModelProtocol
    func itemsDownloaded(items: NSArray) {
        feedItems = items
        self.tableView.reloadData()
        
        let navController = self.tabBarController?.viewControllers![1] as! UINavigationController
        let vc = navController.topViewController as! CategoryTableViewController
        vc.feedItems = feedItems
        
    }

    //
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
        return feedItems.count + 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        if indexPath.row == 0 {
            let firstCell = tableView.dequeueReusableCell(withIdentifier: "FeaturedCell", for: indexPath) as! CustomFeaturedCellTableViewCell
            
            
            return firstCell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! CustomCell
           
            // Get the location to be shown
            let item: RecipeModel = feedItems[indexPath.row - 1] as! RecipeModel
            
            cell.mainImage.image = UIImage(named: images[1])
            
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
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row == 0 {
        return 200;//Choose your custom row height
        }
        else{
            return self.tableView.rowHeight
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
        if(indexPath.row == 0) {
            return
        }
        else {
            selectedRecipe = feedItems[indexPath.row - 1] as! RecipeModel
             self.performSegue(withIdentifier: "recipeSegue", sender: self)
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
