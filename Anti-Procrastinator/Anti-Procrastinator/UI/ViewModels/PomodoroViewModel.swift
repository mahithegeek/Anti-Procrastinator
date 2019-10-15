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
    var secondsString : Observable<String> {get}
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
    var startTimeOfPomodoro : Date = Date()
    weak var delegate : pomodoroViewModelProtocol?
    
    init(){
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
            self.delegate?.secondsString.value = formatSecondsIntoString(seconds: self.breakTime)
            
        }
        else{
            self.stopBreakTimer()
        }
    }
    
    @objc func updateTimer(){
        if(self.seconds > 0){
            self.seconds = self.seconds - 1
            self.delegate?.secondsString.value = formatSecondsIntoString(seconds: self.seconds)
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
        }
    }
    
    //MARK: -  Private methods
    
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
    
    private func formatSecondsIntoString(seconds : Int)->String {
        let minutes = seconds / 60
        let secondsRemaining = seconds - (minutes * 60)
        return String(format: "%d : %02d", minutes,secondsRemaining)
    }
    
    
}
