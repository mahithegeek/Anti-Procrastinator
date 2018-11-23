//
//  PomodoroViewModel.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit

class PomodoroViewModel {

    var timer = Timer()
    var timerState : TimerState = .stopped
    var seconds = 1500
    
    init(){
        
    }
    
    func startPomodoroTimer(){
        timerState = .running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds = seconds - 1
        DispatchQueue.main.async {
            //self.updateLabel()
        }
    }
    
    
}
