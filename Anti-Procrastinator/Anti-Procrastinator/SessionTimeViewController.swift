//
//  SessionTimeViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 05/02/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit

class SessionTimeViewController: UIViewController {

    public var startLabelText : String?
    public var endLabelText : String?
    @IBOutlet weak var startLabel : UILabel?
    @IBOutlet weak var endLabel : UILabel?
    
    convenience init(startLabelString:String,endLabelString:String){
        self.init();
        self.startLabel?.text = startLabelString
        self.endLabel?.text = endLabelString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startLabel?.text = startLabelText
        self.endLabel?.text = endLabelText

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
