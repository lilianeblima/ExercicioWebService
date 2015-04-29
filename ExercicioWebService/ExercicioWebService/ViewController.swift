//
//  ViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/27/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelBronze1: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let notif: NSNotificationCenter = NSNotificationCenter.defaultCenter()

        notif.addObserver(self, selector: "getLabels:", name: "switchingViews", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getLabels(arrLabels: NSNotification) {
        //pegar e mostrar labels
    }

    
    
   
}

