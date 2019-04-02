//
//  PomodoroInterfaceController.swift
//  Anti-Procrastinator-miniature Extension
//
//  Created by nimma01 on 07/03/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import WatchKit
import Foundation


class PomodoroInterfaceController: WKInterfaceController {

    @IBOutlet weak var pomodoroButton : WKInterfaceButton!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func onPomoClicked(){
        let pomodoro = PomodoroViewModel()
        pomodoro.startPomodoroTimer()
    }

}
