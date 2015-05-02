//
//  RepositoryObject.swift
//  ExercicioWebService
//
//  Created by Liliane Bezerra Lima on 30/04/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class RepositoryObject: NSObject {
    
    var parent:NSString?
    var name: NSString?
    var descrip: String?
    var milestone: String?
    var pullUrl: String?
    var comments: String?
    var state: String?
    //var labels: NSString!
    var labels: Array<LabelObject>?
   
}


