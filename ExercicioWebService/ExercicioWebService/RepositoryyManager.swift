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
    
    func deleteAll()
    {
        let fetchRequest = NSFetchRequest(entityName: RepositoryManager.entityName)
        var error:NSError?
        
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [NSManagedObject]
        
       
        
        if let results = fetchedResults as? [Repositoryy] {
            for var i = 0; i < results.count; ++i
            {
               managedContext.delete(results[i])
            }
            
        } else {
            println("Could not fetch. Error: \(error), \(error!.userInfo)")
        }
//
//        NSFetchRequest(entityName: "FetchRequest")
//        
//        return Array<Repositoryy>()
        
        //managedContext.deleteObject(managedContext)
        //managedContext.delete(managedContext)
    }
    
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
    
    
    
    
}
