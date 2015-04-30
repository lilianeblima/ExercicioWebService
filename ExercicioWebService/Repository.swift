//
//  Repository.swift
//  
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//
//

import Foundation
import CoreData

@objc(Repository)
class Repository: NSManagedObject {

    @NSManaged var parent: String
    @NSManaged var name: String
    @NSManaged var labels: NSSet

}
