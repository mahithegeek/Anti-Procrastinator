//
//  Pomodoro.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import UIKit
import CoreData

class Pomodoro: NSManagedObject {
    @NSManaged var dateCompleted : Date?
    
    convenience init(dateCompleted:Date,context:NSManagedObjectContext?){
        var entity : NSEntityDescription?
        if(context == nil){
            entity = NSEntityDescription.entity(forEntityName: "Pomodoro", in: StorageLayer.sharedInstance.getContext())
        }
        self.init(entity: entity!, insertInto: context)
        self.setValue(dateCompleted, forKey: "dateCompleted")
    }

}
