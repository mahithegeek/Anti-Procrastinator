//
//  TaskRootViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 29/01/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit

class TaskRootViewController: UIViewController,UIPageViewControllerDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var pageViewController : UIPageViewController?
    //self.PageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    override func viewDidLoad() {
        self.pageViewController = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController)
        //UIStoryboard
        self.pageViewController?.dataSource = self
        self.pageViewController?.setViewControllers([viewControllerAtIndex(index: 0)], direction: .forward, animated: true, completion: nil)
        
        self.pageViewController?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height - 30)
        
        self.addChild(self.pageViewController!)
        
        self.view.addSubview((self.pageViewController?.view)!)
        self.pageViewController?.didMove(toParent: self)
        
    }
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! TaskInputViewController
        let index =  controller.taskType
        if(index?.rawValue == 0 || index?.rawValue == NSNotFound){
            return nil
        }
        
        return viewControllerAtIndex(index: (index?.rawValue)!-1)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let controller = viewController as! TaskInputViewController
        let index =  controller.taskType
        if(index?.rawValue == 0 || index?.rawValue == NSNotFound){
            return nil
        }
        
        return viewControllerAtIndex(index: (index?.rawValue)!+1)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    
    
    
    func viewControllerAtIndex(index:Int)-> TaskInputViewController {
        
        let taskType : Task = Task(rawValue: index)!
        switch taskType {
        case .eatFruit:
            let fruitTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            fruitTask.taskType = Task.eatFruit
            return fruitTask
        
        case .exercise:
            let exerciseTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            exerciseTask.taskType = Task.exercise
            return exerciseTask
        case .laugh:
            let laughTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            laughTask.taskType = Task.exercise
            return laughTask
        case .learn:
            let fruitTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            fruitTask.taskType = Task.eatFruit
            return fruitTask
        case .meditate:
            let fruitTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            fruitTask.taskType = Task.eatFruit
            return fruitTask
        case .read:
            let fruitTask : TaskInputViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TaskInputViewController") as! TaskInputViewController
            fruitTask.taskType = Task.eatFruit
            return fruitTask
        }
        
        
    }

}


