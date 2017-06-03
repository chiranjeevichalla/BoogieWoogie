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
//        let bSchoolId = "21ae64c2-f0f1-44d8-a1d2-606b09b32e75"
        var bRef : FIRDatabaseReference!
        bRef = FIRDatabase.database().reference(withPath: "\(pSchoolId)/calender")
        
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
//            bRef.re
        }) { (error) in
            Commons.hideIndicator()
//            bRef.removeObserver(withHandle: bObserver)
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
    
    
    class func GetAttendanceList(callback:@escaping (Attendance,Bool) -> Void, callback1:@escaping ([Attendance],Bool) -> Void) -> FIRDatabaseReference {
        
        
        var bRef : FIRDatabaseReference!
        bRef = FIRDatabase.database().reference(withPath: "\(Constants.sharedInstance._child.getSchoolId())/\(Constants.sharedInstance._child.getParentId())/\(Constants.sharedInstance._child.getChildId())/\(Constants.sharedInstance._child.getStandardId())||\(Constants.sharedInstance._child.getStandardId())/attendance_msgs")
        
//        if !IsConnectedToNetwork() {
//            Commons.hideIndicator()
//            Commons.showNoNetwork()
//            
//            return bRef
//        }
        
        bRef.removeAllObservers()
        
        bRef.observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if postDict != nil {
                let bAttendance = Mapper<Attendance>().map(JSON: postDict)
                if bAttendance != nil {
                    if callback != nil {
                        callback(bAttendance!, true)
                    } else {
                        bRef.removeAllObservers()
                    }
                }
                
            }
            //            let value = snapshot.value as? NSDictionary
            //            let username = value?["username"] as? String ?? ""
            
        })
        
        return bRef
        
    }
    
    class func GetCategories(callback:@escaping (Category,Bool) -> Void, callback1:@escaping ([Category],Bool) -> Void) -> FIRDatabaseReference {
        
        Commons.showIndicator()
        var bRef : FIRDatabaseReference!
        let bPath = "19107ff1-ea59-43c0-83a2-9962df79dfae/addCategories"
//        let bPath = "\(Constants.sharedInstance._child.getSchoolId())/addCategories"
        bRef = FIRDatabase.database().reference(withPath: bPath)
        
        
        bRef.removeAllObservers()
        
//        bRef.observe(.childAdded, with: { (snapshot) in
//            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            if postDict != nil {
//                let bCategory = Mapper<Category>().map(JSON: postDict)
//                bCategory?._key = snapshot.key
//                if bCategory != nil {
//                    if callback != nil {
//                        callback(bCategory!, true)
//                    } else {
//                        bRef.removeAllObservers()
//                    }
//                }
//                
//            }
//            //            let value = snapshot.value as? NSDictionary
//            //            let username = value?["username"] as? String ?? ""
//            
//        })
        
        bRef.observeSingleEvent(of: .value, with: { (snapshot) in
            var bCategories : [Category] = []
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshots {
                    if let postDict = snap.value as? [String : AnyObject] {
                        let bCategory = Mapper<Category>().map(JSON: postDict)
                        bCategory?._key = snap.key
                        if bCategory != nil {
                            bCategories.append(bCategory!)
                        }
                    }
                }
            }
            callback1(bCategories, true)
            Commons.hideIndicator()
        }) { (error) in
            callback1([], false)
            Commons.hideIndicator()
        }
        
        return bRef
        
    }
    
}
