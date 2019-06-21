//
//  ProductiveHoursViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit


class ProductiveHoursViewController: UIViewController {
    
    @IBOutlet weak var completedPomodoro : UILabel?
    @IBOutlet weak var pomodoroHours : UILabel?
    @IBOutlet weak var manualHours : UILabel?
    @IBOutlet weak var productiveHours : UILabel?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Productive Hours"
        self.completedPomodoro?.text = String(format: "%d",StorageLayer.sharedInstance.getPomodoroCount())
        let secondsComputed = computePomodoroHours()
        
        let (hours,minutes,seconds) = secondsToHoursMinutesSeconds(seconds: secondsComputed)
        let pomodoroHoursText = String(format: "%02d : %02d : %02d",hours,minutes,seconds)
        self.pomodoroHours?.text = pomodoroHoursText
        self.productiveHours?.text = pomodoroHoursText
        
    }
    
    private func computePomodoroHours()->Int{
        let pomodoros = StorageLayer.sharedInstance.getPomodoroCount()
        let seconds = pomodoros * 25 * 60
        return seconds
    }
    
    private func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
    @IBAction func onExportClicked(){
        let pomodoroData = StorageLayer.sharedInstance.getPomodoroRecords()
        let exportDataObject = formatData(pomodoroObject: pomodoroData)
        
        
        DataExporter().exportData(data: exportDataObject, completion: {completed,error in
            if(!completed){
                //show error
            }
        });
    }
    
    private func formatData(pomodoroObject:[Pomodoro])->[Any]{
        
        var pomodoroDataFormatted : [Any] = []
        for pomodoroData in pomodoroObject {
            let dateStartedString = getFormattedDateString(date:pomodoroData .dateStarted ??  Date(timeIntervalSince1970: 0))
            let dateCompletedString = getFormattedDateString(date: pomodoroData.dateCompleted ??  Date(timeIntervalSince1970: 0))
            let tempData = [dateStartedString,dateCompletedString]
            pomodoroDataFormatted.append(tempData)
        }
        return pomodoroDataFormatted
    }
    
    private func getFormattedDateString(date:Date)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        let dateString = dateformatter.string(from: date )
        return dateString
        
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
