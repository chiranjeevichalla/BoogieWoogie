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
    
    class func didRead(pId: String) -> Bool {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return false
        }
        
        
        let managedContext =
            appDelegate.databaseContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: "NotificationDB1", in: managedContext)
        
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
        
//        let entity = NSEntityDescription.entity(
//            forName: "Contacts", in: context)
        
    }
    
    class func setRead(pId: String, pDidRead : Bool) {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.databaseContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "NotificationDB1",
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
    
}
