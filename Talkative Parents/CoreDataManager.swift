//
//  CoreDataManager.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 22/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    class func didRead(pId: String, pEntityName : String) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        
        let managedContext =
            appDelegate.databaseContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: pEntityName, in: managedContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        let pred = NSPredicate(format: "(id = %@)", pId)
        fetchRequest.predicate = pred
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                return true
            } else {
                return false
            }
        } catch let _ {
            // Handle error
        }
        return false
    }
    
    class func setRead(pId: String, pDidRead : Bool, pEntityName : String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.databaseContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: pEntityName,
                                       in: managedContext)!
        
        let bNotification = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        bNotification.setValue(pId, forKeyPath: "id")
        bNotification.setValue(pDidRead, forKey: "didRead")
        
        // 4
        do {
            try managedContext.save()
            //            people.append(person)
        } catch let error as NSError {
            print("Could not save setRead. \(error), \(error.userInfo)")
        }
    }
    
    class func deleteObject(pId: String, pEntityName : String) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext =
            appDelegate.databaseContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: pEntityName, in: managedContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        let pred = NSPredicate(format: "(id = %@)", pId)
        fetchRequest.predicate = pred
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                do {
                    for object in results {
                        try managedContext.delete(object as! NSManagedObject)
                    }
                    try managedContext.save()
                } catch let _ {
                    
                }
            }
        } catch let _ {
            // Handle error
        }
        
    }
    
    class func noticeBoardDidRead(pId : String) -> Bool {
        return CoreDataManager.didRead(pId:pId, pEntityName: "NotificationDB1")
    }
    
    class func noticeBoardSetRead(pId: String, pDidRead : Bool) {
        CoreDataManager.setRead(pId: pId, pDidRead: pDidRead, pEntityName: "NotificationDB1")
    }
    
    class func calendarEventDidRead(pId: String) -> Bool {
        return CoreDataManager.didRead(pId: pId, pEntityName: "CalendarEventDB")
    }
    
    class func calendarEventSetRead(pId: String, pDidRead : Bool) {
        CoreDataManager.setRead(pId: pId, pDidRead: pDidRead, pEntityName: "CalendarEventDB")
    }
    
    class func calendarEventDeleteObject(pId: String) {
        CoreDataManager.deleteObject(pId: pId, pEntityName: "CalendarEventDB")
    }

    
}
