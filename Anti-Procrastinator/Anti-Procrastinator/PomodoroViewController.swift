//
//  PomodoroViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 22/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit

enum TimerState : Int{
    case running = 1
    case paused = 2
    case stopped = 3
};

class PomodoroViewController: UIViewController {

    @IBOutlet weak var timerLabel : UILabel?
    @IBOutlet weak var playButton : UIButton?
    var timer = Timer()
    var timerState : TimerState = .stopped
    var seconds = 1500
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        playButton?.imageView?.contentMode = .scaleAspectFit
        startPomodoroTimer()
    }
    
    
    func startPomodoroTimer(){
        timerState = .running
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds = seconds - 1
        DispatchQueue.main.async {
            self.updateLabel()
        }
    }
    
    func updateLabel(){
        let minutes = seconds / 60
        let secondsRemaining = seconds - (minutes * 60)
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
