//
//  LabelsTableViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 5/4/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class LabelsTableViewController: UITableViewController {
    
    var labelsCD:Labels?
    var repositoriesCD:Repositoryy?
    var numberLabels: Int?
    var repoLabels = Array<String>() //[String]?
    
    var labelsCoreData:Array<Labels> = {
        return LabelsManager.sharedInstance.getLabel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        println(repositoriesCD?.labels.count)
        numberLabels = repositoriesCD?.labels.count
        
        self.title = "Labels"
        
//        var repoLabels:Array<Labels> = labelsCoreData
        
        for label in repositoriesCD!.labels {
            println(label.name)
            //repoLabels
            repoLabels.append(label.name as String)
            println(repoLabels.count)
            
        }
        
        
        self.Label()
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
        if numberLabels > 0 {
            return numberLabels!
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) as! UITableViewCell
        
        let nameLabel = repoLabels[indexPath.row]
        
        cell.textLabel!.text = nameLabel

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
    
    func Label()
    {
        for label in repositoriesCD!.labels {
            //println(label.name)
            
            
            //            var labelC = LabelsManager.sharedInstance.newLabel()
            //            labelC.name = label.name!
            //            labelC.color = label.color!
            //            labelC.repository = repositoryCoreData
            //            LabelsManager.sharedInstance.save()
            //            labelsCoreData = LabelsManager.sharedInstance.getLabel()
        }
    }

}
