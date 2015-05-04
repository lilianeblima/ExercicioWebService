//
//  TableViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/28/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    
    var defaults = NSUserDefaults.standardUserDefaults()
    var defaultUser = NSUserDefaults.standardUserDefaults()
    var UserConnect:NSString?
    var MyTextField: UITextField?
    var UserName: NSString?
    var teste: NSMutableArray!
    var people = [NSManagedObject]()
    var UserGitSettings:String?
    var isFirstAccess: Int?
    var repositories = Array<RepositoryObject>()
    let ws = Webservice()
    var alertLoad:UIAlertController?
    lazy var repositoriesCoreData:Array<Repositoryy> = {
        return RepositoryManager.sharedInstance.getRepository()
        }()
    lazy var labelsCoreData:Array<Labels> = {
        return LabelsManager.sharedInstance.getLabel()
        }()


    

///=============================BOTAO===========================================
    @IBAction func ChangeUser(sender: AnyObject) {
        
        self.addAlertUser()
    }
    
///==================Funcoes Padroes===================================
    override func viewDidLoad() {
        super.viewDidLoad()
        UserConnect = defaultUser.objectForKey("UserConnect") as! NSString?
        self.title = self.UserConnect as String?
       //
       //UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        
        //Faz a leitura do CoreData e recarrega a tabela
        repositoriesCoreData = RepositoryManager.sharedInstance.getRepository()
        self.tableView.reloadData()
        
        //Seleciona um usuario
        self.UserSelec()
    }
    
    override func viewDidAppear(animated: Bool) {

        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesCoreData.count

    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        //self.AlertFinish()//PARA TESTAR COM ALERTA CARREGANDO DESCOMENTE AKI
        let repoCoreData:Repositoryy = repositoriesCoreData[indexPath.row]

        cell.textLabel!.text = repoCoreData.name
        


        return cell
    }
    
    func getDetails(arrayLabels: NSNotification) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //========Notification Center==========
        let notif: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        let repoCoreData:Repositoryy = repositoriesCoreData[indexPath.row]
        var labs: NSDictionary = NSDictionary(object: repoCoreData.labels, forKey: "Labels")
        
        notif.postNotificationName("switchingViews", object: self, userInfo: labs as? [NSObject: AnyObject])
        
        //        var arrLabels: NSDictionary = NSDictionary(object: labels, forKey:"passInfo")
        //        notif.postNotificationName("allLabels", obje		ct: self, userInfo: arrLabels as [NSObject: AnyObject])


    }
    
//================================FUNCOES=======================================
    
    ///===========Funcao que verifica se ja tem usuario configurado nos settings======
    func UserSelec(){
     //   self.AlertLoading()
        UserGitSettings = self.defaultUser.objectForKey("userGitHub") as? String
        if UserGitSettings == nil || UserGitSettings == ""{
            isFirstAccess = defaults.objectForKey("isFirstAccess") as! Int?
            if isFirstAccess == nil{
                self.addAlertUser()
            }
        }
        else{
            if UserGitSettings != UserConnect{
                self.UserConnect = UserGitSettings
                self.defaultUser.setValue(self.UserConnect, forKey: "UserConnect")
                self.SearchWEB()
            }
            else{
                self.SearchWEB()
            }
            self.defaults.setValue(1, forKey: "isFirstAccess")
            isFirstAccess = defaults.objectForKey("isFirstAccess") as! Int?
            
            
        }
    }
    
//================================Alertas======================================
 /// Alerta Principal para inserir usuario
    func addAlertUser()
    {
        let alert:UIAlertController = UIAlertController(title: "Pesquisa de usuário", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler{
            textField -> Void in
            self.MyTextField = textField
        }
        //Caso nao seja o primeiro acesso, possibilita que seja cancelado a operacao
        if isFirstAccess != nil{
            let cancel:UIAlertAction = UIAlertAction(title: "Cancel", style: .Default){ action -> Void in
            }
            alert.addAction(cancel)
        }
        
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            if self.MyTextField!.text == "" {
                self.addAlertErro()
            }
            else{
                    self.UserConnect = self.MyTextField?.text
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
               // self.AlertLoad()//PARA TESTAR COM ALERTA CARREGANDO DESCOMENTE AKI

                    self.SearchWEB()
                
                
            }
        }
        
        alert.addAction(action1)
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
  /// Alerta Secundário para informar que é preciso preencher o usuario
    func addAlertErro()
    {
        let alert:UIAlertController = UIAlertController(title: "Erro", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            self.addAlertUser()
        }
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: {
        })
    }
    
  /// Alerta caso nao encontre usuário
    func AlertUser()
    {
        let alert:UIAlertController = UIAlertController(title: "Erro! Usuario Invalido", message: "Verifique o usuario e tente novamente ", preferredStyle: .Alert)
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            self.addAlertUser()
        }
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: {
        })
    }
    
    func AlertLoad()
    {
        alertLoad = UIAlertController(title: "Carregando", message: "Aguarde ", preferredStyle: .Alert)
        
        self.presentViewController(alertLoad!, animated: true, completion: {
        })
    }
    
    func AlertFinish()
    {
        let alert:UIAlertController = UIAlertController(title: "Dados Carregados", message: "Pressione OK para concluir a operacao ", preferredStyle: .Alert)
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
        }
        alert.addAction(action1)
        
        self.presentViewController(alert, animated: true, completion: {
        })
    }

///================================Buscas na WEB==================================
    func SearchWEB(){
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            //Faz a busca na WEB
            if let user = self.UserConnect as? String {
                if let repos: Array<RepositoryObject> = self.ws.getRepoArray (user) {
                    self.repositories = repos
                    
                    //Caso nao encontre o usuário pesquisado
                    if repos.count == 0{
                        
                        let priorityy = DISPATCH_QUEUE_PRIORITY_DEFAULT
                        dispatch_async(dispatch_get_global_queue(priorityy, 0)) {
                            self.AlertUser()
                            dispatch_async(dispatch_get_main_queue()) {
                                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                            }
                        }
                        
                        
                        
                    }
                    else{
                        //Salva as informacoes
                        self.defaultUser.setValue(self.UserConnect, forKey: "UserConnect")
                        self.defaultUser.setValue(self.UserConnect, forKey: "userGitHub")
                        self.defaults.setValue(1, forKey: "isFirstAccess")
                        self.isFirstAccess = self.defaults.objectForKey("isFirstAccess") as! Int?
                        self.tableView.reloadData()
                        self.UserConnect = self.defaultUser.objectForKey("UserConnect") as! NSString?
                        
                        //Limpa o CoreData
                        RepositoryManager.sharedInstance.deleteAll()
                        
                        //Salva no banco de dados
                        for repository in self.repositories {
                            self.SaveRepositoryCoreData(repository)
                        }
                        
                    }
                }
            }
            self.tableView.reloadData()
            self.title = self.defaultUser.objectForKey("UserConnect") as! String?

            dispatch_async(dispatch_get_main_queue()) {
               // self.AlertLoad() //PARA TESTAR COM ALERTA CARREGANDO DESCOMENTE AKI
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
        }
        
        
        
    }
    
//===================SALVANDO OBJETOS NO COREDATA===============================
    
    ///Salva o objeto repositorio que vem da WEB no CoreData
    func SaveRepositoryCoreData(repositoryWeb:RepositoryObject){
        var reposi = RepositoryManager.sharedInstance.newRepository()
        reposi.name = repositoryWeb.name!
        
        //Salva as labels
        self.SaveLabelsCoreData(repositoryWeb, repositoryCoreData: reposi)
        RepositoryManager.sharedInstance.save()
        repositoriesCoreData = RepositoryManager.sharedInstance.getRepository()
    }
    
    ///Salva as Labels
    func SaveLabelsCoreData(repositoryWeb:RepositoryObject, repositoryCoreData:Repositoryy)
    {
        for label in repositoryWeb.labels {
            var labelC = LabelsManager.sharedInstance.newLabel()
            labelC.name = label.name!
            labelC.color = label.color!
            labelC.repository = repositoryCoreData
            LabelsManager.sharedInstance.save()
            labelsCoreData = LabelsManager.sharedInstance.getLabel()
        }
    }

}
