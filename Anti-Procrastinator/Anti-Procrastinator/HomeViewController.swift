//
//  ViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 22/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var pomodoroButton : UIButton?
    @IBOutlet weak var productiveHours : UIButton?
    @IBOutlet weak var funHours : UIButton?
    @IBOutlet weak var taskInput : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Home"
    }
    
    

}

