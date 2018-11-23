//
//  ProductiveHoursViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit


class ProductiveHoursViewController: UIViewController {
    
    @IBOutlet weak var completedPomodoro : UILabel?
    @IBOutlet weak var pomodoroHours : UILabel?
    @IBOutlet weak var manualHours : UILabel?
    @IBOutlet weak var productiveHours : UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.completedPomodoro?.text = String(format: "%d",StorageLayer.sharedInstance.getPomodoroCount())
        let secondsComputed = computePomodoroHours()
        
        let (hours,minutes,seconds) = secondsToHoursMinutesSeconds(seconds: secondsComputed)
        let pomodoroHoursText = String(format: "%02d : %02d : %02d",hours,minutes,seconds)
        self.pomodoroHours?.text = pomodoroHoursText
        self.productiveHours?.text = pomodoroHoursText
        
    }
    
    private func computePomodoroHours()->Int{
        let pomodoros = StorageLayer.sharedInstance.getPomodoroCount()
        let seconds = pomodoros * 25 * 60
        return seconds
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
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
