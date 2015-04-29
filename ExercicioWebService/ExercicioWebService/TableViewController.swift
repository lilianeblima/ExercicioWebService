//
//  TableViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/28/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var MyTextField: UITextField!
    var UserName: NSString?
    var teste: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        //Teste - tirar
        let ws = Webservice()
        var s = ws.getMackmobileForks("jhpg")
    }

    
    
    override func viewDidAppear(animated: Bool) {
        self.addAlert()
        
    }
    
    
    
    func addAlert()
    {
        let alert:UIAlertController = UIAlertController(title: "Pesquisa de usuário", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        
        alert.addTextFieldWithConfigurationHandler{
            textField -> Void in
            self.MyTextField = textField
        }
        
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            
            if self.MyTextField.text == "" {
                self.addAlert()
            }
            self.UserName = self.MyTextField.text
            print(self.UserName)
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
        return teste!.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        var i: NSInteger
        i = indexPath.row
        
        cell.textLabel?.text = teste[indexPath.row] as? String
        
        return cell
    }
    
    func getDetails(arrayLabels: NSNotification) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let notif: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
//        var arrLabels: NSDictionary = NSDictionary(object: labels, forKey:"passInfo")
//        notif.postNotificationName("allLabels", object: self, userInfo: arrLabels as [NSObject: AnyObject])
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
