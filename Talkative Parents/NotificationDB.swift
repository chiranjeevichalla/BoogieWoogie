//
//  NotificationDB.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 20/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import CoreData

class NotificationDB: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
}

extension NotificationDB {
    
    @NSManaged var id: String?
    @NSManaged var didRead: String?
    
}
