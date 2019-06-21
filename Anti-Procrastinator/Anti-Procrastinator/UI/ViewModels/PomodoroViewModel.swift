//
//  PomodoroViewModel.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit
import AVFoundation

protocol pomodoroViewModelProtocol : AnyObject {
    func onPomodoroCompleted()
    func onBreakTimeCompleted()
}

extension pomodoroViewModelProtocol {
    func onPomodoroCompleted(){
        AudioServicesPlaySystemSound(1328);
    }
}


enum TimerState : Int{
    case running = 1
    case paused = 2
    case stopped = 3
};

class PomodoroViewModel {
    static let pomodoroTimeConstant : Int = 3//1500
    static let breakTimeConstant : Int = 300
    var timer = Timer()
    var breakTimer = Timer()
    var timerState : TimerState = .stopped 
    var seconds = pomodoroTimeConstant
    var breakTime = breakTimeConstant
    var secondsString : DynamicString
    var startTimeOfPomodoro : Date = Date()
    weak var delegate : pomodoroViewModelProtocol?
    
    init(){
        secondsString = DynamicString("1500")
    }
    
    
    func viewLoaded(){
        startPomodoroTimer()
    }
    
    func viewUnloaded(){
        stopPomodoroTimer()
    }
    
    func pauseClicked(){
        if (timerState == .running) {
            stopPomodoroTimer()
            
        }
        else if (timerState == .paused){
            startPomodoroTimer()
        }
    }
    
    func skipBreakClicked(){
        startPomodoroTimer()
    }
    
    
    func startBreak(){
        
        self.seconds = PomodoroViewModel.pomodoroTimeConstant
        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    private func startBreakTimer() {
        self.breakTime = PomodoroViewModel.breakTimeConstant
        self.breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    private func startPomodoroTimer(){
        timerState = .running
        self.startTimeOfPomodoro = Date()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func updateBreakTimer(){
        if(self.breakTime > 0){
            self.breakTime = self.breakTime  - 1
            //self.updateLabelWithTimeLeft(self.breakTimeDuration)
            self.secondsString.value = String(self.breakTime)
        }
        else{
            self.stopBreakTimer()
//            AudioServicesPlaySystemSound(1320);
//            SCLAlertView().showWarning("Hey Dude!!!", subTitle: "Break Time Over!!!").setDismissBlock {
//                self.startPomodoroTimer()
//            }
        }
    }
    
    @objc func updateTimer(){
        if(self.seconds > 0){
            self.seconds = self.seconds - 1
            let minutes = self.seconds / 60
            let secondsRemaining = self.seconds - (minutes * 60)
           // timerLabel?.text = timeLeft//String(format: "%d : %02d", minutes,secondsRemaining)
            self.secondsString.value = String(format: "%d : %02d", minutes,secondsRemaining)
        }
        else{
            stopPomodoroTimer()
            //save pomodoro
            let count = StorageLayer.sharedInstance.getPomodoroCount()
            print("number of Pomos \(count)")
            let pomodoro = Pomodoro(dateStarted:self.startTimeOfPomodoro,dateCompleted: Date(), context: nil)
            let success = StorageLayer.sharedInstance.savePomodoro(pomodoro: pomodoro)
            
            if(success){
                print("Pomodoro Saved successfully")
            }
            else{
                print("Unable to Store Pomodoro Timer")
            }
            
            self.delegate?.onPomodoroCompleted()
            
            resetPomodoro()
            //startPomodoroTimer()
        }
    }
    
    private func resetPomodoro(){
        self.seconds = 1500
    }
    
    private func stopPomodoroTimer(){
        timerState = .paused
        self.timer.invalidate();
    }
    
    private func stopBreakTimer(){
        self.breakTimer.invalidate()
    }
    
    
}
