//
//  DetailedViewController.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 04/12/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit


class DetailedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var detailedTableView : UITableView?
    private var pomodoroData : [Pomodoro]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pomodoroData = StorageLayer.sharedInstance.getPomodoroRecords()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pomodoroData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataCell = UITableViewCell(style: .default, reuseIdentifier: "DataCell")
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        let dateStarted = pomodoroData?[indexPath.row].dateStarted
        let dateCompleted = pomodoroData?[indexPath.row].dateCompleted
        
        let dateStartedString = dateformatter.string(from: dateStarted ?? Date(timeIntervalSince1970: 0))
        let dateCompletedString = dateformatter.string(from: dateCompleted ?? Date(timeIntervalSince1970: 0))
        
        if(dateStartedString.contains("1970")) {
            dataCell.textLabel?.text = "\(dateCompletedString)"
        }
        else{
            dataCell.textLabel?.text = "\(dateStartedString)    \(dateCompletedString)"
        }
        
        return dataCell
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
