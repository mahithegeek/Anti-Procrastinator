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


class PomodoroViewController: UIViewController,pomodoroViewModelProtocol {
    var secondsString: Observable<String>
    
    @IBOutlet weak var timerLabel : UILabel?
    @IBOutlet weak var playButton : UIButton?
    
    var viewModel : PomodoroViewModel!
    
    required init?(coder aDecoder: NSCoder) {
        
        self.secondsString = Observable("1500")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Pomodor Timer"
        self.navigationItem.hidesBackButton = true
        let backButtonImage = UIImage(named: "Back")
        let backButton = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(onBackClicked))
        self.navigationItem.leftBarButtonItem = backButton
        playButton?.imageView?.contentMode = .scaleAspectFit
        
        self.viewModel.delegate = self
        self.viewModel.viewLoaded()
        self.secondsString.bind(listener: {value in self.updateLabelWithTimeLeft(value)})
        
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
            self.viewModel.viewUnloaded()
            self.navigationController?.popViewController(animated: true)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func skipbreak(){
        self.viewModel.skipBreakClicked()
    }
    
    @objc func startBreakTimer(){
        self.viewModel.startBreak()
    }
    
    func updateLabelWithTimeLeft(_ timeLeft:String){
        timerLabel?.text = timeLeft
    }

    
    @IBAction func pauseButtonClicked(){
        self.viewModel.pauseClicked()
        if(self.viewModel.timerState == .running){
            let buttonImage = UIImage(named: "Play")
            DispatchQueue.main.async {
                self.playButton?.setImage(buttonImage, for: UIControl.State.normal)
            }
        }
        else{
            let buttonImage = UIImage(named: "Pause")
            self.playButton?.setImage(buttonImage, for: UIControl.State.normal)
        }
        
    }
    
    //MARK: - View Model Protocol
    
    func onPomodoroCompleted() {
        //TODO : come up with nice titles
        AudioServicesPlaySystemSound(1328);
        
        let alertView = SCLAlertView()
        alertView.addButton("Skip Break", target: self, selector: #selector(skipbreak))
        alertView.addButton("Go for a break", target: self, selector: #selector(startBreakTimer))
        alertView.addButton("Done", action: {
            self.onBackClicked();
        });
        alertView.showSuccess("Well Done!!", subTitle: "What do you want to do now?");
    }
    
    func onBreakTimeCompleted() {
        AudioServicesPlaySystemSound(1320);
        SCLAlertView().showWarning("Hey Dude!!!", subTitle: "Break Time Over!!!").setDismissBlock {
        }
    }
    

}
