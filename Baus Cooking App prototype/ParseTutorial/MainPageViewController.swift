//
//  MainPageViewController.swift
//  ParseTutorial
//
//  Created by Runping Wang on 11/1/15.
//  Copyright © 2015 Ron Kliffer. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
  
  @IBOutlet weak var ingredient: UITextField!
  var result = false
  var recipeArray = [String]()
  override func viewDidLoad() {
    super.viewDidLoad()
    result = false
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func searchItunesFor(searchTerm: String) {
    
    let yummlySearchTerm = searchTerm.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
    let escapedSearchTerm = yummlySearchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
    let urlPath = "http://api.yummly.com/v1/api/recipes?_app_id=2c41f558&_app_key=979af8b5452af1242d5743b267be62ee&q=\(escapedSearchTerm!)"
    let url = NSURL(string: urlPath)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
      print("Task completed")
      if(error != nil) {
        // If there is an error in the web request, print it to the console
        print(error!.localizedDescription)
      }
      let resstr = NSString(data: data!, encoding: NSUTF8StringEncoding)
      
      let range = NSRange(location: 0,length: resstr!.length)
      let jsonString = resstr!.substringWithRange(range)
      
      let newData = (jsonString as NSString).dataUsingEncoding(NSUTF8StringEncoding)
      
            do{
        
        let jsonObject : AnyObject! = try NSJSONSerialization.JSONObjectWithData(newData!, options: NSJSONReadingOptions.MutableContainers)
        
        if let statusesArray = jsonObject as? NSDictionary{
          
          if let aStatus = statusesArray["matches"] as? NSArray{
            var i:Int
            for(i = 0;i<aStatus.count;++i)
            {
              if let recipe = aStatus[i] as? NSDictionary{
                let recipeName = recipe["recipeName"]
                self.recipeArray.append(recipeName! as! String)
              }
            }
            
          }
        }
        self.result = true
      }
      catch let JSONError as NSError {
        print("\(JSONError)")}
      
    })
    
        task.resume()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "recipe"{
      if let destination = segue.destinationViewController as? RecipeViewController{
        destination.recipeList = self.recipeArray
        
      }
    }
  }

  
  @IBAction func pressed(sender: AnyObject) {
    searchItunesFor(ingredient.text!)
    while(self.result == false){}
   
    self.performSegueWithIdentifier("recipe", sender: nil)
      }
  
    
}
