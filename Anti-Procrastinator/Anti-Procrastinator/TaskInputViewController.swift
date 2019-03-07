//
//  TaskInputViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 29/01/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit

enum Task : Int{
    case eatFruit = 0
    case exercise
    case read
    case laugh
    case meditate
    case learn
    
}

class TaskInputViewController: UIViewController {

    var taskType : Task?
    @IBOutlet weak var taskView : TaskCardView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
        if(taskType == Task.eatFruit){
            self.taskView?.taskButton?.titleLabel?.text = "Eat Fruit"
        }
        else if(taskType == Task.exercise){
            self.taskView?.taskButton?.titleLabel?.text = "Exercise"
        }
    }
    
    convenience init(task:Task){
        self.init()
        taskType = task
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
