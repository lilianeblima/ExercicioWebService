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
    
    func getJSONData(urlToRequest: String) -> AnyObject{
        //var data = NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
        
        let conn = Connection()
        conn.connect(urlToRequest)
        var data = conn.data
        
        var error: NSError?
        var dic: AnyObject? = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error)// as! Array<NSDictionary>
        return dic!
    }
    

    //retorna um array com os dados de cada repositório do mackmobile que foi dado fork
    func getMackmobileForks (user: String) -> Array<NSDictionary>{
        
        var error: NSError
        //let userUrl = String(
          //  format: "https://api.github.com/users/%@/repos", user) //Trocar
        let userUrl = "https://api.github.com/users/\(user)/repos"
        let userDic = getJSONData(userUrl) as! Array<NSDictionary>
        
//        if (error != nil) {
//            println("Não foi possível fazer a busca. ERRO: %@", error);
//            return nil
//        }
        
        var repos:Array<NSDictionary> = []
        
        //get the repositories pages
        //for (key, value) in userDic { //para cada repo
          for repo in userDic {
            //let repo = value as! NSDictionary
            let repoUrl: String = repo.objectForKey("url") as! String
            
            //Segundo acesso
            let repoDic = getJSONData(repoUrl) as! NSDictionary
            
            let parentOwner = repoDic.objectForKey("parent")?.objectForKey("owner")?.objectForKey("login")
            
            if (parentOwner != nil && parentOwner?.isEqual("mackmobile") != nil) {
                repos.append(repo)
            }
        }
        return repos
    }
    
//    func getUserData -> User
    
//    func getRepoData -> Repository
    
    
    
    
    
    
    
    
    
    
    

    
    
    
}
