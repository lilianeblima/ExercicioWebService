//
//  LabelsManager.swift
//  ExercicioWebService
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit
import CoreData

public class LabelsManager {
    
    static let sharedInstance:LabelsManager = LabelsManager()
    static let entityName:String = "Labels"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    private init(){}
    
    func newLabel()->Labels
    {
        return NSEntityDescription.insertNewObjectForEntityForName(LabelsManager.entityName, inManagedObjectContext: managedContext) as! Labels
    }
    
    func save()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func getLabel()->Array<Labels>
    {
        let fetchRequest = NSFetchRequest(entityName: LabelsManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Labels] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        return Array<Labels>()
    }
    
    func deleteAll()
    {
        var array: Array<Labels> = getLabel()
        
        for rep: Labels in array{
            managedContext.deleteObject(rep)
            
        }
    }
    
}
