//
//  ViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/27/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var MyTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func viewDidAppear(animated: Bool) {
        self.addAlert()
        
            }
    
    
    
 func addAlert()
 {
    let alert:UIAlertController = UIAlertController(title: "Pesquisa de usuário", message: "Por Favor, insira o user desejado", preferredStyle: .Alert)
    
    alert.addTextFieldWithConfigurationHandler{
        textField -> Void in
        self.MyTextField = textField
    }
    
    let action1:UIAlertAction = UIAlertAction(title: "OK", style: .Default) {action -> Void in
        
        if self.MyTextField.text == "" {
            self.addAlert()
        }

        print(self.MyTextField.text)
    }
    
    alert.addAction(action1)
    
    self.presentViewController(alert, animated: true, completion: {
        
    })
 }
    
   
}

