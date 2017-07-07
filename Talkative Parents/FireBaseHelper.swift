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
//import SwiftyJSON

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
        let bString = "||"
        bRef = FIRDatabase.database().reference(withPath: "\(Constants.sharedInstance._child.getSchoolId())/\(Constants.sharedInstance._child.getParentId())/\(Constants.sharedInstance._child.getChildId())/\(Constants.sharedInstance._child.getStandardId())\(bString)\(Constants.sharedInstance._child.getSectionId())/attendance_msgs")
        print("attendence url \(bRef.url)")
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
//                        bRef.removeAllObservers()
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
//        let bPath = "19107ff1-ea59-43c0-83a2-9962df79dfae/addCategories"
        let bPath = "\(Constants.sharedInstance._child.getSchoolId())/addCategories"
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
    
    class func AddSoundingBoardMessage(pAttachment : UIImage?, pMessage : SoundingBoard, pType : String, callback:@escaping (Bool) -> Void) {
        
        //pType is private or public
        var bRef : FIRDatabaseReference!
//        let bPath = "sb-2/\(pType)/S-19107ff1-ea59-43c0-83a2-9962df79dfae-d3aaa86a-4c61-4c60-91dd-9201faa71baa/chat"
      let bPath = "sb-2/\(pType)/\(Constants.sharedInstance._child.getSchoolId())/chat/\(Constants.sharedInstance._child.getSchoolToParentChannelId())"
        
        bRef = FIRDatabase.database().reference(withPath: bPath)
        print("add sounding board message url \(bRef.url)")
        pMessage.setDate(pValue: Commons.getCurrentDateToString())
        pMessage.setActive(pBool: true)
        pMessage.setParentName(pValue: Constants.sharedInstance._parent.getName())
//        bRef.removeAllObservers()
        if pAttachment != nil {
            AppService.UploadFile(pFileName: Commons.getUniqueStringId(), pImage: pAttachment!, pIsProfile: false, callback: { (pAttachmentLink, result) in
                if result {
                    pMessage.setAttachment(pValue: pAttachmentLink)
                    bRef.childByAutoId().setValue(pMessage.toJSON())
                }
                callback(result)
            })
        } else {
            bRef.childByAutoId().setValue(pMessage.toJSON())
            callback(true)
        }

    }
    
    class func AddCommentToSoundingBoardMessage(pAttachment: UIImage? ,pComment : Comment, pType : String, pSoundingBoard : SoundingBoard, callback:@escaping (Bool) -> Void) {
//        Commons.showIndicator()
        //pType is private or public
        var bRef : FIRDatabaseReference!
//        -KlxJRcspKKlyL0830Za
        //        let bPath = "sb-2/\(pType)/S-19107ff1-ea59-43c0-83a2-9962df79dfae-d3aaa86a-4c61-4c60-91dd-9201faa71baa/comments/-KlxJRcspKKlyL0830Za"
        let bPath = "sb-2/\(pType)/\(Constants.sharedInstance._child.getSchoolId())/comments/\(Constants.sharedInstance._child.getSchoolToParentChannelId())/\(pSoundingBoard.getFirebaseKey())"
        bRef = FIRDatabase.database().reference(withPath: bPath)
        pComment.setPostedDate(pValue: Commons.getCurrentDateToString())
        pComment.setPostedBy(pValue: Constants.sharedInstance._parent.getName())
        pComment.setPostedById(pValue: Constants.sharedInstance._parent.getId())
        //        bRef.removeAllObservers()
//        Commons.showIndicator()
        if pAttachment != nil {
            let bFileName = Commons.getUniqueStringId()
            AppService.UploadFile(pFileName: bFileName, pImage: pAttachment!, pIsProfile: false, callback: { (pAttachmentLink, result) in
                
                if result {
                    pComment.setAttachment(pValue: pAttachmentLink)
                    bRef.childByAutoId().setValue(pComment.toJSON())
                } else {
//                    bRef.childByAutoId().setValue(pComment.toJSON())
                }
                callback(result)
            })
        }
        else {
            bRef.childByAutoId().setValue(pComment.toJSON())
            callback(true)
//            Commons.hideIndicator()
        }
        
    }
    
    
    //done
    class func UpdateSoundingBoardCommentsCount(pType: String, pCount : Int, pSoundingBoard : SoundingBoard) {
        var bRef : FIRDatabaseReference!
        //        -KlxJRcspKKlyL0830Za
        //        let bPath = "sb-2/\(pType)/S-19107ff1-ea59-43c0-83a2-9962df79dfae-d3aaa86a-4c61-4c60-91dd-9201faa71baa/comments/-KlxJRcspKKlyL0830Za"
        let bPath = "sb-2/\(pType)/\(Constants.sharedInstance._child.getSchoolId())/chat/\(Constants.sharedInstance._child.getSchoolToParentChannelId())/\(pSoundingBoard.getFirebaseKey())/commentsCount"
        bRef = FIRDatabase.database().reference(withPath: bPath)

        bRef.setValue(pCount)
        
    }
    //done
    class func GetSoundingBoard(pType : String, callback:@escaping (SoundingBoard,Bool) -> Void, callback1:@escaping ([SoundingBoard],Bool) -> Void, onChildChanged:@escaping (SoundingBoard,Bool) -> Void) -> FIRDatabaseReference {
        
        
        var bRef : FIRDatabaseReference!
        let bPath = "sb-2/\(pType)/\(Constants.sharedInstance._child.getSchoolId())/chat/\(Constants.sharedInstance._child.getSchoolToParentChannelId())"
        bRef = FIRDatabase.database().reference(withPath: bPath)
        
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
                let bSoundingBoard = Mapper<SoundingBoard>().map(JSON: postDict)
                if bSoundingBoard != nil {
                    bSoundingBoard?.setFirebaseKey(pKey: snapshot.key)
                    if callback != nil {
                        callback(bSoundingBoard!, true)
                    } else {
//                        bRef.removeAllObservers()
                    }
                }
                
            }
            
        })
        
        bRef.observe(.childChanged, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            if postDict != nil {
                let bSoundingBoard = Mapper<SoundingBoard>().map(JSON: postDict)
                if bSoundingBoard != nil {
                    bSoundingBoard?.setFirebaseKey(pKey: snapshot.key)
                    onChildChanged(bSoundingBoard!, true)
                }
                
            }
            
        })
        
        return bRef
        
    }
    
    //done
    class func GetSoundingBoardComments(pType : String, pSoundingBoard : SoundingBoard, callback:@escaping (Comment,Bool) -> Void, callback1:@escaping ([Comment],Bool) -> Void) -> FIRDatabaseReference {
        
        
        var bRef : FIRDatabaseReference!
        let bPath = "sb-2/\(pType)/\(Constants.sharedInstance._child.getSchoolId())/comments/\(Constants.sharedInstance._child.getSchoolToParentChannelId())/\(pSoundingBoard.getFirebaseKey())"
        bRef = FIRDatabase.database().reference(withPath: bPath)
        
        //        if !IsConnectedToNetwork() {
        //            Commons.hideIndicator()
        //            Commons.showNoNetwork()
        //
        //            return bRef
        //        }
        
        bRef.removeAllObservers()
        
        bRef.observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
//            if postDict != nil {
                let bSoundingBoardComment = Mapper<Comment>().map(JSON: postDict)
                if bSoundingBoardComment != nil {
                    bSoundingBoardComment?.setFirebaseKey(pKey: snapshot.key)
//                    if callback != nil {
                        callback(bSoundingBoardComment!, true)
//                    } else {
                        //                        bRef.removeAllObservers()
//                    }
                }
                
//            }
            
        })
        
        bRef.observe(.value, with: { (snapshot) in
//            if snapshot != nil {
                if snapshot.hasChildren() {
                    FireBaseHelper.UpdateSoundingBoardCommentsCount(pType: pType, pCount: Int(snapshot.childrenCount), pSoundingBoard: pSoundingBoard)
                }
            callback1([], true)
//            }
        })
        
        return bRef
        
    }
    
}
