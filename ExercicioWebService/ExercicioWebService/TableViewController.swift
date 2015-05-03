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
    var repositories = Array<RepositoryObject>()
    let ws = Webservice()
    
    lazy var repositoriesCoreData:Array<Repositoryy> = {
        return RepositoryManager.sharedInstance.getRepository()
        }()
    
    lazy var labelsCoreData:Array<Labels> = {
        return LabelsManager.sharedInstance.getLabel()
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        
        
        //let repos: Array<RepositoryObject> = ws.getRepoArray("JHPG")
        
        
        
        
        
        /// Teste - tirar
        UserConnect = defaultUser.objectForKey("UserConnect") as! NSString?
        self.title = self.UserConnect as? String
        
        
//        if let user = UserConnect as? String {
//            if let repos: Array<RepositoryObject> = ws.getRepoArray (user) {
//                self.repositories = repos
//            }
//        }
        
    }

    @IBAction func ChangeUser(sender: AnyObject) {
        
        self.addAlertUser()
    }
    
    
    override func viewDidAppear(animated: Bool) {
//Le o CoreData quando inicia o aplicativo e recarrega a tabela
        repositoriesCoreData = RepositoryManager.sharedInstance.getRepository()
        self.tableView.reloadData()
//Verifica se é o primeiro acesso para enviar a mensagem de inserir usuario
        var isFirstAccess: Int? = defaults.objectForKey("isFirstAccess") as! Int?
        if isFirstAccess == nil
        {
            self.addAlertUser()
        }
        
        println(self.UserConnect)
    }
    
// Funcoes que geram os alertas
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
    
    func addAlertUser()
    {
        let alert:UIAlertController = UIAlertController(title: "Pesquisa de usuário", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler{
            textField -> Void in
            self.MyTextField = textField
        }
        
        let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
            if self.MyTextField!.text == "" {
                self.addAlertErro()
            }
            else{
            //Caso Pressione OK e esteja com nome de usuario preenchido
                
                //Configuracoes para indicar que ja passou a primeira vez
                self.defaultUser.setValue(self.MyTextField?.text, forKey: "UserConnect")
                self.defaults.setValue(1, forKey: "isFirstAccess")
                self.tableView.reloadData()
                self.UserConnect = self.defaultUser.objectForKey("UserConnect") as! NSString?
                
                //Buscas na Web
                if let user = self.UserConnect as? String {
                    if let repos: Array<RepositoryObject> = self.ws.getRepoArray (user) {
                        self.repositories = repos
                   //     RepositoryManager.sharedInstance.deleteAll()
                        //Salva no banco de dados
                        for repository in self.repositories {
                            self.SaveRepositoryCoreData(repository)
                        }
                       
                    }
                }
                self.tableView.reloadData()
                
                self.title = self.UserConnect as? String
 
            }

            
        }
        
        alert.addAction(action1)
        self.presentViewController(alert, animated: true, completion: {
            
        })
    }
    
  //Salva o objeto repositorio que vem da WEB no CoreData
    func SaveRepositoryCoreData(repositoryWeb:RepositoryObject){
        var reposi = RepositoryManager.sharedInstance.newRepository()
        reposi.name = repositoryWeb.name!
        //reposi.parent = repositoryWeb.parent!
        
        //Salva as labels
        self.SaveLabelsCoreData(repositoryWeb, repositoryCoreData: reposi)
        RepositoryManager.sharedInstance.save()
        repositoriesCoreData = RepositoryManager.sharedInstance.getRepository()
    }
    
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
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositoriesCoreData.count
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
      //  return teste!.count
        //return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        
        /// Repositório da célula
        //let repo:RepositoryObject = repositories[indexPath.row]
        let repoCoreData:Repositoryy = repositoriesCoreData[indexPath.row]
      //  self.SaveRepositoryCoreData(repo)
        
      //  let repoCoreData:Repositoryy = repositoriesCoreDara[indexPath.row]
       // cell.textLabel!.text = repoCoreData.name
          //  repo.name
        cell.textLabel!.text = repoCoreData.name
        //cell.textLabel!.text = "tem linha"
        

        
        

        return cell
    }
    
    func getDetails(arrayLabels: NSNotification) {
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let notif: NSNotificationCenter = NSNotificationCenter.defaultCenter()
        
        let repoCoreData:Repositoryy = repositoriesCoreData[indexPath.row]
        
        var labs: NSDictionary = NSDictionary(object: repoCoreData.labels, forKey: "Labels")
        
        notif.postNotificationName("switchingViews", object: self, userInfo: labs as? [NSObject: AnyObject])
        
//        var arrLabels: NSDictionary = NSDictionary(object: labels, forKey:"passInfo")
//        notif.postNotificationName("allLabels", obje		ct: self, userInfo: arrLabels as [NSObject: AnyObject])
    }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
