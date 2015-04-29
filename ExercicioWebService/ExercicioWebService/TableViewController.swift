//
//  TableViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/28/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    
    var defaults = NSUserDefaults.standardUserDefaults()
    var MyTextField: UITextField!
    var UserName: NSString?
    var people = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    
    
    override func viewDidAppear(animated: Bool) {
        var isFirstAccess: Int? = defaults.objectForKey("isFirstAccess") as! Int?
        if isFirstAccess == nil
        {
            self.addAlertUser()
        }
        
    }
    
    func addAlertErro()
    {
        let alert:UIAlertController = UIAlertController(title: "Erro", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        
        
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            self.addAlertUser()
            
        }
        
        
        
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
    var person:NSManagedObject?
    
    func addAlertUser()
    {
        let alert:UIAlertController = UIAlertController(title: "Pesquisa de usuário", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            textField -> Void in
            self.MyTextField = textField
        }
        
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            
            
            
            if self.MyTextField.text == "" {
                self.addAlertErro()
            }
            else{
                self.defaults.setValue(1, forKey: "isFirstAccess")
                //self.defaults.setValue("false", forKey: "isFirstAccess")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                
                let managedContext = appDelegate.managedObjectContext!
                
                let entity = NSEntityDescription.entityForName("User", inManagedObjectContext: managedContext)
                
                self.person = NSManagedObject(entity: entity!,
                    insertIntoManagedObjectContext:managedContext)
                
                //3
               self.person!.setValue(self.MyTextField.text, forKey: "name")
                self.tableView.reloadData()
                
                
                //4
                var error: NSError?
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                }  
                //5
               // self.people.append(person)
                
            }

            
        }
        
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        
        //let person = people[indexPath.row]
        self.UserName = self.person?.valueForKey("name") as? String
        print(self.UserName)
        cell.textLabel?.text = self.person?.valueForKey("name") as? String

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
