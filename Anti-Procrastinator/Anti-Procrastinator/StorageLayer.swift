//
//  StorageLayer.swift
//  Anti-Procrastinator
//
//  Created by nimma01 on 23/11/18.
//  Copyright © 2018 nimma01. All rights reserved.
//

import Foundation
import UIKit
import CoreData
class StorageLayer {
    static let sharedInstance = StorageLayer()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context : NSManagedObjectContext
    private init(){
         context = appDelegate.persistentContainer.viewContext
    }
    
    public func savePomodoro(pomodoro:Pomodoro)->Bool{
        let pomoDoroToSave = NSEntityDescription.insertNewObject(forEntityName: "Pomodoro", into: self.context) as! Pomodoro
        pomoDoroToSave.dateCompleted = pomodoro.dateCompleted
        
        do {
            try self.context.save()
        }catch let error as NSError {
            print(error.localizedDescription)
            return false
        }
        
        return true
    }
    
    public func getContext()->NSManagedObjectContext{
        return self.context
    }
    
    public func getPomodoroCount()->Int {
        let pomoFetch = NSFetchRequest<NSManagedObject>(entityName: "Pomodoro")
        var pomoList : [Pomodoro]
        
        do {
            try pomoList = self.context.fetch(pomoFetch) as! [Pomodoro]
        } catch {
            fatalError("Faile to fetch Pomos: \(error)")
        }
        
        return pomoList.count
    }
    
    
}
