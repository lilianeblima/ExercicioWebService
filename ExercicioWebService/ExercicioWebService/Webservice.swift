//
//  Webservice.swift
//  ExercicioWebService
//
//  Created by Jorge Henrique P. Garcia on 4/28/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class Webservice: NSObject {
    
    static let sharedInstance:Webservice = Webservice()     //Singleton
    //private init() { }
   
//    var user = ""
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        var error: NSError?
        var dic: NSDictionary = NSJSONSerialization.JSONObjectWithData(inputData, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
        
        return dic
    }
    
    func getUserRepos (user: String) -> NSDictionary{
        
        var error: NSError
        let url = String(
            format: "https://api.github.com/users/%@/repos", user) //Trocar
        let json: NSData = getJSON(url)
        let dic: NSDictionary = parseJSON(json)
        
//        if (error != nil) {
//            println("Não foi possível fazer a busca. ERRO: %@", error);
//            return nil
//        }
        
        return dic
    }
    
    
    
    
    
    
    
    
    
    
    

    
    
    
}
