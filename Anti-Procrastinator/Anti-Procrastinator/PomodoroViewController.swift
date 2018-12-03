//
//  PomodoroViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 22/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit
import SCLAlertView
import AVFoundation

enum TimerState : Int{
    case running = 1
    case paused = 2
    case stopped = 3
};

class PomodoroViewController: UIViewController {

    @IBOutlet weak var timerLabel : UILabel?
    @IBOutlet weak var playButton : UIButton?
    var timer = Timer()
    var breakTimer = Timer()
    var timerState : TimerState = .stopped
    var seconds = 5
    var breakTimeDuration = 3
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Pomodor Timer"
        self.navigationItem.hidesBackButton = true
        let backButtonImage = UIImage(named: "Back")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(onBackClicked))
        self.navigationItem.leftBarButtonItem = backButton
        
        playButton?.imageView?.contentMode = .scaleAspectFit
        startPomodoroTimer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isIdleTimerDisabled = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    @objc private func onBackClicked(){
        //ToDO: Better Message
        let alert = UIAlertController(title: "Please Confirm!!!", message: "Are you sure to stop the current Pomodoro Timer??", preferredStyle:.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.stopTimer()
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func startPomodoroTimer(){
        timerState = .running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    func startBreakTimer(){
        breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateBreakTimer), userInfo: nil, repeats: true)
    }
    
    func resetPomodoro(){
        self.seconds = 1500
    }
    
    @objc func updateTimer(){
        if(self.seconds > 0){
            self.seconds = self.seconds - 1
            DispatchQueue.main.async {
                self.updateLabelWithTimeLeft(self.seconds)
            }
        }
        else{
            stopTimer()
            //save pomodoro
            let count = StorageLayer.sharedInstance.getPomodoroCount()
            print("number of Pomos \(count)")
            let pomodoro = Pomodoro(dateCompleted: Date(), context: nil)
            let success = StorageLayer.sharedInstance.savePomodoro(pomodoro: pomodoro)
            
            //TODO : come up with nice titles
            AudioServicesPlaySystemSound(1328);
            SCLAlertView().showSuccess("Hey Master!!!", subTitle: "Cool !!!Done with a Pomodoro!!!").setDismissBlock {
                //show break
                print("break time")
                self.startBreakTimer()
                
            }
            resetPomodoro()
            //startPomodoroTimer()
        }
    }
    
    @objc func updateBreakTimer(){
        if(self.breakTimeDuration > 0){
            self.breakTimeDuration = self.breakTimeDuration  - 1
            self.updateLabelWithTimeLeft(self.breakTimeDuration)
            
        }
        else{
            self.stopBreakTimer()
            AudioServicesPlaySystemSound(1320);
            SCLAlertView().showWarning("Hey Dude!!!", subTitle: "Break Time Over!!!").setDismissBlock {
                self.startPomodoroTimer()
            }
        }
    }
    
    func updateLabelWithTimeLeft(_ timeLeft:Int){
        let minutes = timeLeft / 60
        let secondsRemaining = timeLeft - (minutes * 60)
        timerLabel?.text = String(format: "%d : %02d", minutes,secondsRemaining)
    }

    
    @IBAction func pauseButtonClicked(){
        if (timerState == .running) {
            stopTimer()
            let buttonImage = UIImage(named: "Play")
            DispatchQueue.main.async {
                self.playButton?.setImage(buttonImage, for: UIControl.State.normal)
            }
            
        }
        else if (timerState == .paused){
            let buttonImage = UIImage(named: "Pause")
            self.playButton?.setImage(buttonImage, for: UIControl.State.normal)
            startPomodoroTimer()
        }
        
    }
    
    func stopTimer(){
        timerState = .paused
        self.timer.invalidate();
    }
    
    func stopBreakTimer() {
        self.breakTimer.invalidate()
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
