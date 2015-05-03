//
//  RepositoryManager.swift
//  ExercicioWebService
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit
import CoreData

public class RepositoryManager {
    static let sharedInstance:RepositoryManager = RepositoryManager()
    static let entityName:String = "Repositoryy"
    lazy var managedContext:NSManagedObjectContext = {
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        var c = appDelegate.managedObjectContext
        return c!
        }()
    
    
    private init(){}
    
    
    func newRepository()->Repositoryy
    {
        return NSEntityDescription.insertNewObjectForEntityForName(RepositoryManager.entityName, inManagedObjectContext: managedContext) as! Repositoryy
    }
    
    func save()
    {
        var error:NSError?
        managedContext.save(&error)
        
        if let e = error {
            println("Could not save. Error: \(error), \(error!.userInfo)")
        }
    }
    
    func getRepository()->Array<Repositoryy>
    {
        let fetchRequest = NSFetchRequest(entityName: RepositoryManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
        if let results = fetchedResults as? [Repositoryy] {
            return results
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
        
        NSFetchRequest(entityName: "FetchRequest")
        
        return Array<Repositoryy>()
    }
    
    func deleteAll()
    {
        var array: Array<Repositoryy> = getRepository()
        
        for rep: Repositoryy in array{
            managedContext.deleteObject(rep)
            
        }
    }
    
    
    
    
    
    
}
