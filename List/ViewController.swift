//
//  ViewController.swift
//  List
//
//  Created by Mac Bellingrath on 7/9/15.
//  Copyright © 2015 com.mbellingrath. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
    
    var items = [NSManagedObject]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell!
        let item = items[indexPath.row]
        cell.textLabel!.text = item.valueForKey("name") as? String
       
        return cell
        
      
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        
        var alert = UIAlertController(title: "Add Item", message: "Please add an item", preferredStyle: .Alert)
      
        //Save new item
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            
            let textField = alert.textFields![0] as UITextField
            self.saveName(textField.text!)
            self.tableView.reloadData()
            }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) { (action: UIAlertAction!) -> Void in
        
            }
        alert.addTextFieldWithConfigurationHandler{ (textField: UITextField!) -> Void in
            
            }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "\"Things\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Item")
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                items = results
            }
        } catch {
            
            print("An Error Has Occurred")
            
        }
        
        
      
       
        
        
    }
    
    func saveName(name: String) {
   
        //1
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: managedContext)
        
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        //3
        item.setValue(name, forKey: "name")
        
        // 4
        
        do {
            try managedContext.save()
            print("saved")
        } catch {
            print(("Could not save"))
            
            
        }
        
        
        //5
        items.append(item)
        
    }
    
    


}

