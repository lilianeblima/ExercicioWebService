//
//  Labels.swift
//  
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//
//

import Foundation
import CoreData

@objc(Labels)
class Labels: NSManagedObject {

    @NSManaged var color: String
    @NSManaged var name: String
    @NSManaged var repository: Repository

}
