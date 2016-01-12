//
//  RecipeViewController.swift
//  Baus Cooking
//
//  Created by Yi He on 11/22/15.
//  Copyright © 2015 Ron Kliffer. All rights reserved.
//

import Foundation
import UIKit

class RecipeViewController: UITableViewController{
  
  let TempViewController : MainPageViewController = MainPageViewController(nibName : nil, bundle: nil)
  var recipeList = [String]()
  //let recipeList = TempViewController.recipeArray
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    //print(self.recipeList)
    //self.recipeList = TempViewController.recipeArray
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
    // Dispose of any resources that can be recreated.
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.recipeList.count
  }

  
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
    
    var recipe: String
    
    recipe = recipeList[indexPath.row]

    cell.textLabel?.text = recipe    
    
    return cell
  }
  
  
}
