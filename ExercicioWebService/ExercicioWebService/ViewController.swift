//
//  ViewController.swift
//  ExercicioWebService
//
//  Created by Lidia Chou on 4/27/15.
//  Copyright (c) 2015 Lidia Chou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var labelsCD:Labels?
    var repositoriesCD:Repositoryy?

    @IBOutlet weak var labelBronze1: UILabel!
    @IBOutlet weak var labelBronze2: UILabel!
    @IBOutlet weak var labelBronze3: UILabel!
    @IBOutlet weak var labelBronze4: UILabel!
    @IBOutlet weak var labelBronze5: UILabel!
    @IBOutlet weak var labelBronze6: UILabel!
    @IBOutlet weak var labelProbBronze: UILabel!
    
    @IBOutlet weak var labelPrata1: UILabel!
    @IBOutlet weak var labelPrata2: UILabel!
    @IBOutlet weak var labelPrata3: UILabel!
    @IBOutlet weak var labelProbPrata: UILabel!
    
    @IBOutlet weak var labelOuro1: UILabel!
    @IBOutlet weak var labelOuro2: UILabel!
    @IBOutlet weak var labelOuro3: UILabel!
    @IBOutlet weak var labelProbOuro: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        println(repositoriesCD?.labels.count)
        
        // Do any additional setup after loading the view, typically from a nib.
        
//        let notif: NSNotificationCenter = NSNotificationCenter.defaultCenter()
//        
//        notif.addObserver(self, selector: "getLabels:", name: "switchingViews", object: nil)
        
        

        //notif.addObserver(self, selector: "getLabels:", name: "switchingViews", object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func getLabels(labelName: NSNotification) {
//        //pegar e mostrar labels
//
//    }

    
    
   
}

