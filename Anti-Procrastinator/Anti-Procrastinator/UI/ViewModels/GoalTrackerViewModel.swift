//
//  GoalTrackerViewModel.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 02/04/19.
//  Copyright © 2019 nimma01. All rights reserved.
//

import UIKit

class GoalTrackerViewModel: NSObject {
    var percentage : Observable<String>
    let bufferDays = 30
    
    override init(){
        percentage = Observable("152")
        super.init()
    }
    
    
    func fillUI(){
        let daysLeft = checkDayDifference()
        self.percentage.value = String(daysLeft)
    }
    
    
    private func checkDayDifference()->Int {
        var dateComponents = DateComponents()
        dateComponents.year = 2019
        dateComponents.month = 9
        dateComponents.day = 30
        dateComponents.timeZone = TimeZone(abbreviation: "IST")
        
        let userCalendar = Calendar.current
        let zeroDay = userCalendar.date(from: dateComponents)
        
        let currentDay = Date()
        
        let components =  Calendar.current.dateComponents([Calendar.Component.day], from: currentDay, to: zeroDay!)
        return components.day! - self.bufferDays
        
    }
}
