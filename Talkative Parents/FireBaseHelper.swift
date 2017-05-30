//
//  FireBaseHelper.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 29/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import Firebase
import ObjectMapper

class FireBaseHelper {
    
    
    
    class func SetCalendarFirebaseEventObserver(pSchoolId : String, callback:@escaping (CalendarEvent,Bool) -> Void, callback1:@escaping ([CalendarEvent],Bool) -> Void) -> FIRDatabaseReference {
        
        Commons.showIndicator()
        
//
//        
//
        let bSchoolId = "21ae64c2-f0f1-44d8-a1d2-606b09b32e75"
        var bRef : FIRDatabaseReference!
        bRef = FIRDatabase.database().reference(withPath: "\(bSchoolId)/calender")
        
        if !IsConnectedToNetwork() {
                        Commons.hideIndicator()
                        Commons.showNoNetwork()
            
                        return bRef
                    }
        
        let bDate = Date()
        
        
        bRef.observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if postDict != nil {
//                let bCalendarEvent = Mapper.mapDictionary(postDict<CalendarEvent>)
//                let user = Mapper<User>().map(JSONString: JSONString)
                let bCalendarEvent = Mapper<CalendarEvent>().map(JSON: postDict)
                if bCalendarEvent != nil {
                    if (bCalendarEvent?.getStartDate())! >= bDate {
                        let bStandardId = bCalendarEvent?.getStandardId()
                        if bStandardId == "" || bStandardId?.lowercased() == "all" || bStandardId == Constants.sharedInstance._child.getStandardId() {
                                let bSectionId = bCalendarEvent?.getSectionId()
                                if bSectionId == "" || bSectionId == Constants.sharedInstance._child.getSectionId() || bSectionId?.lowercased() == "all" {
                                    callback(bCalendarEvent!, true)
                                }
                        }
                    }
                }
                
            }
//            let value = snapshot.value as? NSDictionary
//            let username = value?["username"] as? String ?? ""
            
        })
        
//        bRef.observe(.value, with: { (snapshot) in
////            print(snapshot)
//            Commons.hideIndicator()
//            callback1([], true)
//            //             let lJsonArray = snapshot.value as? [[String : AnyObject]]
//            //             {
//            //                let bCalendarEvents = Mapper<CalendarEvent>().mapArray(JSONArray: lJsonArray!)
//            //                print("\(bCalendarEvents)")
//            //            }
//            
//        })
        
        bRef.observe(.value, with: { (snapshot) in
            Commons.hideIndicator()
        }) { (error) in
            Commons.hideIndicator()
            Commons.showErrorMessage(pMessage: "\(error.localizedDescription)")
        }
        
//        bRef.onDisconnectRemoveValue { (error, reference) in
//            print("DISCONNECTED")
//            Commons.hideIndicator()
//            if error != nil {
//                Commons.showErrorMessage(pMessage: "\(error?.localizedDescription)")
//            }
//        }
        
        return bRef
        
    }
    
}
