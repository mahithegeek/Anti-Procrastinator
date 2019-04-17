//
//  GoalTrackViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 02/04/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit

class GoalTrackViewController: UIViewController {
    
    var goalTrackerViewModel : GoalTrackerViewModel!
    @IBOutlet weak var daysLeft : UILabel!
    @IBOutlet weak var imageBG : UIImageView!
    var currentPercentage: Double?
    var progressBar : UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.goalTrackerViewModel.percentage.bind(listener: {value in self.updateDaysLeft(value: value)})
        self.goalTrackerViewModel.fillUI()
        addProgressView()
        
    }
    
    func addProgressView() {
        progressBar = UIProgressView(frame: CGRect(x: 10, y: 100, width: 300, height: 100))
        progressBar.center = self.view.center
        progressBar.progress = Float(self.currentPercentage!)
        progressBar.progressTintColor = UIColor.green
        progressBar.trackTintColor = UIColor.red
        progressBar.layer.cornerRadius = 6.5
        progressBar.clipsToBounds = true
        progressBar.transform = CGAffineTransform(rotationAngle: .pi / -2)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.imageBG.addSubview(progressBar)
        progressBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        progressBar.widthAnchor.constraint(equalToConstant: 300).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    
    func updateDaysLeft(value:String){
        self.daysLeft.text = value + " " + "Days Left"
        self.currentPercentage = Double(value)! / 150.0
        refreshProgressView()
        
    }
    
    private func refreshProgressView(){
        progressBar?.progress = Float(self.currentPercentage!)
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
