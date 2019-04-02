//
//  PomodoroTimerInterfaceController.swift
//  Anti-Procrastinator-miniature Extension
//
//  Created by nimma01 on 20/03/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import WatchKit
import Foundation


class PomodoroTimerInterfaceController: WKInterfaceController {

    var pomodoroViewModel : PomodoroViewModel
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        self.pomodoroViewModel.pomodoroTime.bindAndFire { [unowned self] in self.seconds = $0
            self.updateTimer()
        }
        
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
