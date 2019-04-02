//
//  PomodoroViewModel.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit

enum TimerState : Int{
    case running = 1
    case paused = 2
    case stopped = 3
};

class PomodoroViewModel {

    var timer = Timer()
    var timerState : TimerState = .stopped
    var pomodoroTime: Dynamic<Int>
    var breakTimeDuration: Dynamic<Int>
    var breakTimer = Timer()
    
    init(){
        self.breakTimeDuration = Dynamic(300)
        self.pomodoroTime = Dynamic(1500)
    }
    
    func startPomodoroTimer(){
        timerState = .running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        self.pomodoroTime.value = self.pomodoroTime.value - 1
        DispatchQueue.main.async {
            //self.updateLabel()
        }
    }
    
    func stopTimer(){
        timerState = .paused
        self.timer.invalidate();
    }
    
    @objc func startBreakTimer(){
        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func stopBreakTimer() {
        self.breakTimer.invalidate()
    }
    
    @objc func updateBreakTimer(){
        if(self.breakTimeDuration.value > 0){
            self.breakTimeDuration.value = self.breakTimeDuration.value  - 1
            //self.updateLabelWithTimeLeft(self.breakTimeDuration)
            
        }
        else{
            self.stopBreakTimer()
            //AudioServicesPlaySystemSound(1320);
           // SCLAlertView().showWarning("Hey Dude!!!", subTitle: "Break Time Over!!!").setDismissBlock {
                self.startPomodoroTimer()
            }
        }
    }
    

