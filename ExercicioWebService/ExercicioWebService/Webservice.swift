//
//  Webservice.swift
//  ExercicioWebService
//
//  Created by Jorge Henrique P. Garcia on 4/28/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class Webservice: NSObject {
    
    /// Singleton
    static let sharedInstance:Webservice = Webservice()     //Singleton
    
    //private init() { }
   
/// Retorna o NSData da url já autenticado (síncrono)
    func getData (url: String) -> NSData? {
        // set up the base64-encoded credentials
        let username = "webserviceGit"
        let password = "webserviceGit123"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let url2 = NSURL(string: url)
        let request = NSMutableURLRequest(URL: url2!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        var response: NSURLResponse?; var error: NSError?
        let data: NSData? = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        return data
    }
    
/// Retorna os dados JSON de uma URL (String)
    func getJSONData(urlToRequest: String) -> AnyObject?{
        
        /// Objeto de retorno
        var dic: AnyObject?
        
        if let data = getData(urlToRequest) {  // may return nil, too
            
            var error: NSError?
            dic = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error)
            
        } else {
            println("Não foi possível ler o valor NSData da url passada (já excedeu o limite do GitHub)")
        }
        return dic
    }
    

/// Retorna um array com os dados de cada repositório do mackmobile que foi dado fork
    func getMackmobileForks (user: String) -> Array<NSDictionary>{
        
        var error: NSError
        let userUrl = "https://api.github.com/users/\(user)/repos"
        let userDic = getJSONData(userUrl) as! Array<NSDictionary>
        
        /// Array de dicionários com os repositórios fork
        var repos:Array<NSDictionary> = []
        
        //get the repositories pages
          for repo in userDic { //para cada repo
            //let repo = value as! NSDictionary
            let repoUrl: String = repo.objectForKey("url") as! String
            
            /// Segundo acesso
            let repoDic = getJSONData(repoUrl) as! NSDictionary
            
            if let parentOwner:String = repoDic.objectForKey("parent")?.objectForKey("owner")?.objectForKey("login") as? String{
                //Verifica na variável criada se é nula
                if parentOwner.isEqual("mackmobile") { //Se for um fork do mackmobile
                    repos.append(repo)
                }
            }
        }
        return repos
    }
    
//    func getUserData (String user) -> User
    
/// Array de dictionary da página de issues do GitHub
    func genIssueArray (user: String) -> Array<NSDictionary>{
        
        let repoDics: Array<NSDictionary> = getMackmobileForks(user)
        var issueArray = Array<NSDictionary>()
        
        for repoDic in repoDics {
            //let pulls: AnyObject = getJSONData( (repoDic.objectForKey("pulls_url") as! String) )
            let repoName = repoDic.objectForKey("name") as! String
            
            /// Temp object - é passado junto com a issue como value
            var repo = RepositoryObject()
            repo.name = repoName
            repo.descrip = repoDic.objectForKey("description") as? String
            
            /// Saber se tem pulls (flag)
            var temPull = false
            
            // Se tiver pull requests
            if let pulls = getJSONData( "https://api.github.com/repos/mackmobile/\(repoName)/pulls") as? Array<NSDictionary>{
                for pullReq in pulls {
                    
                    let pullUser = pullReq.objectForKey("user")?.objectForKey("login") as? String
                    //Se o usuário for o que deu pull
                    if (pullUser == user) {
                        let issue = getJSONData((pullReq.objectForKey("issue_url") as! String)) as! NSDictionary
                        issue.setValue(repo, forKey: "repoTemp")
                        issueArray.append(issue)
                        temPull = true
                    }
                }
                if !temPull {
                    var issue = ["repoTemp": repo]
                    issueArray.append(issue)
                }
            } else {
                var issue = ["repoTemp": repo]
                issueArray.append(issue)
            }
            
        }
        return issueArray
    }
    
/// Array de objetos Repository (apenas forks do mackmobile)
    func getRepoArray(user: String) -> Array<RepositoryObject>? {
        
        var repoArray = Array<RepositoryObject>()
        
        for repoDic in genIssueArray(user){
            
            let repoTemp = repoDic.valueForKey("repoTemp") as! RepositoryObject
            var repo = RepositoryObject()
            
            repo.name = repoTemp.name
            repo.descrip = repoTemp.descrip
            repo.pullUrl = repoDic.objectForKey("html_url") as? String
            if let milestone = repoDic.objectForKey("milestone") as? NSDictionary {
                repo.milestone = milestone.objectForKey("title") as? String
            }
            repo.comments = repoDic.objectForKey("comments") as? String
            repo.state = repoDic.objectForKey("state") as? String
            
            if let tempLabelsArray = repoDic.objectForKey("labels") as? Array<NSDictionary> {
                var labelsArray = Array<LabelObject>()
                
                for tempLabel in tempLabelsArray {
                    var label = LabelObject()
                    label.name = tempLabel.objectForKey("name") as? String
                    label.color = tempLabel.objectForKey("color") as? String
                    
                    labelsArray.append(label)
                }
                repo.labels = labelsArray   //Associa vetor de labels ao repositório
            }
            repoArray.append(repo)
        }
        return repoArray
    }
    
}
