//
//  RepositoryObject.swift
//  ExercicioWebService
//
//  Created by Jorge Henrique P. Garcia on 5/1/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class RepositoryObject: NSObject {
    
    var parent: String?
    var name: String?
    var descrip: String?
    var milestone: String?
    var pullUrl: String?
    var comments: String?
    var state: String?
    //var labels: String?
    var labels = Array<LabelObject>()
   
}


