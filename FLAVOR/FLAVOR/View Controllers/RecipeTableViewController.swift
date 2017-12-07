//
//  RecipeTableViewController.swift
//  FLAVOR
//
//  Created by Lukáš Lipovský on 05/12/2017.
//  Copyright © 2017 Lukáš Lipovský. All rights reserved.
//

import UIKit
import CoreData

class RecipeTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    var selectedRecipe : RecipeModel?
    var isFavourite : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        
        changeNavigationButtons()
        
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true;
        
    }
    
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if(navigationController!.viewControllers.count > 1){
            self.navigationController?.navigationBar.prefersLargeTitles = true
            return true
        }
        return false
    }
    
    func changeNavigationItemsImage() {
        let imageName: String
        if isRecipeFavourite() {
            imageName = "ic_favorites_orange"
            isFavourite = true
            
        }
        else {
            imageName = "ic_favorite_orange"
            isFavourite = false
        }
        self.navigationItem.rightBarButtonItem?.image = UIImage(named: imageName)
    }
    
    
    func changeNavigationButtons() {
        //create a new button
        let button: UIButton = UIButton(type: UIButtonType.custom)
        //set image for button
        let imageName: String
        if isRecipeFavourite() {
            imageName = "ic_favorites_orange"
            isFavourite = true
            
        }
        else {
            imageName = "ic_favorite_orange"
            isFavourite = false
        }
        button.setImage(UIImage(named: imageName), for: UIControlState.normal)
        //add function for button
        button.addTarget(self, action: #selector(addToFavourites(_:)), for: UIControlEvents.touchUpInside)
        //set frame
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
        
        
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
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        changeNavigationButtons()
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
@objc func backToPreviousView(_ button: UIButton) {
    _ = navigationController?.popViewController(animated: true)
    self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
@objc func addToFavourites(_ button: UIButton) {
    let recipeID = selectedRecipe?.id
    //isFavourite = isRecipeFavourite()
    
    let button: UIButton = UIButton(type: UIButtonType.custom)
    let imageName: String
    //set image for button
    if isFavourite == false {
        imageName = "ic_favorites_orange"//`button.setImage(UIImage(named: ), for: UIControlState.normal)
        isFavourite = true
        self.saveToDataModel(id: Int(recipeID!)!)
    }
    else {
        imageName = "ic_favorite_orange"//button.setImage(UIImage(named: "ic_favorite_orange"), for: UIControlState.normal)
        isFavourite = false
        removeDataFromModel(id: Int(recipeID!)!)
    }
    
    //add function for button
    button.setImage(UIImage(named: imageName), for: UIControlState.normal)
    button.addTarget(self, action: #selector(addToFavourites(_:)), for: UIControlEvents.touchUpInside)
    
    let barButton = UIBarButtonItem(customView: button)
    
    
    self.navigationItem.rightBarButtonItem = barButton
    
    
    }

    func isRecipeFavourite() -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                print("an error has occured")
                return false
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        // 2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
        
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [FavRecipe]
        
        for object in resultData {
            if(object.id == (Int((selectedRecipe?.id)!)!) ) {
                return true
            }
        }
        return false
    }
    
    func removeDataFromModel(id: Int) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        // 2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
        
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [FavRecipe]
        
        for object in resultData {
            if(object.id == (Int((selectedRecipe?.id)!)!) ) {
                managedContext.delete(object)
            }
        }
        
        do {
            try managedContext.save()
            print("deleted!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch {
            
        }
        
    }
    
    func saveToDataModel(id: Int) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // Check if it is already favourite
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavRecipe")
        
        let result = try? managedContext.fetch(fetchRequest)
        let resultData = result as! [FavRecipe]
        
        for object in resultData {
            if(object.id == Int((selectedRecipe?.id!)!)!) {
                return
            }
        }
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "FavRecipe",
                                       in: managedContext)!
        
        let recipe = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        recipe.setValue(id, forKeyPath: "id")
        
        // 4
        do {
            try managedContext.save()
            //people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if(selectedRecipe == nil) {
            return 0
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, reif let id = selectedRecipe.id? {
        
        if let ingredientsCount = selectedRecipe?.ingredients?.count {
            if let instructionsCount = selectedRecipe?.instructions?.count {
                return 6 + ingredientsCount + instructionsCount
            }
        }
            
        
       
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if(indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeImageCell") as! CustomRecipeImageCell
            cell.mainImage.image = UIImage(named: "Pancakes")
            return cell
        }
        else if(indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCategoryCell") as! CustomRecipeCategoryCell
            cell.categoryLabel.text = selectedRecipe?.category
            return cell
        }
        else if(indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTitleCell") as! CustomRecipeTitleCell
            cell.titleLabel.text = selectedRecipe?.name
            return cell
        }
        else if(indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIconsCell") as! CustomRecipeIconsCell
            cell.timeLabel.text = selectedRecipe?.cooking_time
            cell.difficultyLabel.text = selectedRecipe?.difficulty
            cell.servingsLabel.text = selectedRecipe?.serving
            
            return cell
        }
        else if(indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeSectionTitleCell") as! CustomRecipeSectionTitleCell
            let sectionTitle = "INGREDIENCIE"
            
            let attributedString = NSMutableAttributedString(string: sectionTitle)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: CGFloat(1.75), range: NSRange(location: 0, length: attributedString.length - 1))
            
            cell.sectionTitle.attributedText = attributedString
            
            return cell
        }
        else if(indexPath.row > 4 && indexPath.row <= (selectedRecipe?.ingredients?.count)! + 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeIngredientsCell") as! CustomRecipeIngredientsCell
            cell.numberLabel.text = "- "
            cell.ingredientLabel.text = selectedRecipe?.ingredients?[indexPath.row-5]
            
            return cell
        }
        else if(indexPath.row == 5 + (selectedRecipe?.ingredients?.count)!) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeSectionTitleCell") as! CustomRecipeSectionTitleCell
            let sectionTitle = "POSTUP"
            
            let attributedString = NSMutableAttributedString(string: sectionTitle)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: CGFloat(1.75), range: NSRange(location: 0, length: attributedString.length - 1))
            
            cell.sectionTitle.attributedText = attributedString
            
            return cell
        }
        else {
            let element = indexPath.row - (6 + (selectedRecipe?.ingredients?.count)!)
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeInstructionsCell") as! CustomRecipeInstructionsCell
            cell.numberLabel.text = String(element + 1)
            cell.instructionLabel.text = selectedRecipe?.instructions?[element]
            
            return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
