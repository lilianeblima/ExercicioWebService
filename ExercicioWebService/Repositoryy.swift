//
//  Repositoryy.swift
//  ExercicioWebService
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import Foundation
import CoreData

@objc(Repositoryy)
class Repositoryy: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var parent: String
    @NSManaged var labels: NSSet

}
