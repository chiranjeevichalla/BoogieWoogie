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
import OneSignal

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

    class func setAllNotificationTagsStatus(pStatus : Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext =
            appDelegate.databaseContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "NotificationTags", in: managedContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                do {
                    for object in results {
                        let bObject = object as! NSManagedObject
                        bObject.setValue(pStatus, forKey: "didRead")
                        
                    }
                    try managedContext.save()
                } catch let _ {
                    
                }
            }
        } catch let _ {
            // Handle error
        }
    }
    
    class func deleteNotificationTags() {
        //Fetch all tags and check didRead status as false, if false delete Tag and delete from DB
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext =
            appDelegate.databaseContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "NotificationTags", in: managedContext)
        
        // Configure Fetch Request
        fetchRequest.entity = entityDescription
        
        do {
            let results =
                try managedContext.fetch(fetchRequest)
            if results.count > 0 {
                do {
                    for object in results {
                        let bObject = object as! NSManagedObject
                        let bKey = bObject.value(forKey: "id") as? String
                        if let bResult = bObject.value(forKey: "didRead") as? Bool {
                            if bResult == false {
                                do {
                                    try managedContext.delete(bObject)
                                    if bKey != nil {
                                        OneSignal.deleteTag(bKey!)
                                    }
                                } catch let _ {
                                    
                                }
                                
                            }
                        }

                    }
                    try managedContext.save()
                } catch let _ {
                    
                }
            }
        } catch let _ {
            // Handle error
        }
    }
    
    class func sendNotificationTag(pKey : String) {
        //send tag to onesignal
        OneSignal.sendTag(pKey, value: "1")
        //check the db if not exist add to db and set status as 1
        if CoreDataManager.didRead(pId: pKey, pEntityName: "NotificationTags") {
            
        } else {
            CoreDataManager.setRead(pId: pKey, pDidRead: true, pEntityName: "NotificationTags")
        }
        
    }
    
}
