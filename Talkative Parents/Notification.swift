//
//  Notification.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 20/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper







class TPNotification : Mappable {
    
    
    var _subject : String?
    var _id : String?
    var _classes : String?
    var _isEntireSchool : Bool?
    var _parentsString : String?
    
    var _sections : String?
    
    var _dateTimeSent : String?
    
    var _type : Int?
    var _isParticularSection : Bool?
    var _firstName : String = ""
    var _stateId : Int?
    var _attachmentString : String?
    //Attachment format 
//    "Attachments" : "9799d094-cdc3-471f-80bb-335500064e2b_photo_2017-04-21_12-23-13.jpg;7998ba64-f319-49cb-a8cc-6e1c815fb9b1_photo_2017-04-21_12-22-49.jpg;f7ffd7cc-e241-4e88-a78c-e48f1af5ff03_photo_2017-04-21_12-22-57.jpg;dea88dc9-a36f-4964-886c-9a372c87c19c_photo_2017-04-21_12-31-58.jpg;388eafbe-3472-47d9-9aa8-e95c181577ed_photo_2017-04-21_12-24-18.jpg;c53380f4-e4ca-4a0d-8d93-14c0ccc2ff3f_photo_2017-04-21_12-31-52.jpg;d0c27d42-b170-4f58-a36d-89c43f9ab123_photo_2017-04-21_12-24-45.jpg;77d861e3-fb3d-4870-9f97-8de45b9cbb77_photo_2017-04-21_12-20-06.jpg;1582df12-66f9-4238-8320-b30304987c79_photo_2017-04-21_12-22-34.jpg;874b55d4-0030-4258-992f-4b6b83c513c8_photo_2017-04-21_12-24-18.jpg",
    var _hasAttachment : Bool = false
    //another attachment model need to create
    var _isParticularClass : Bool?
    var _schoolName : String?
    var _isParticularParent : Bool?
    var _oneSignal : String?
    var _didRead : Bool = false
    
    var _messageType : Int = 0 //1 - admin, 2 - scho0l
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _subject        <- map ["Subject"]
        _id             <- map ["Id"]
        _classes        <- map["Classes"]
        _isEntireSchool <- map["IsEntireSchool"]
        _parentsString  <- map["Parents"]
        _sections       <- map["Sections"]
        _dateTimeSent <- map["DateTimeSent"]
        _type           <- map["Type"]
        _isParticularSection    <- map["IsParticularSection"]
        _attachmentString       <- map["Attachments"]
        _isParticularClass      <- map["IsParticularClass"]
        _schoolName             <- map["SchoolName"]
        _isParticularParent     <- map["IsParticularParent"]
        _oneSignal              <- map["OneSignal"]
        
        if _dateTimeSent != nil {
            _dateTimeSent = Commons.convertStringToDateFormat(pDate: _dateTimeSent!)
        }
        
        if _attachmentString != nil {
            _hasAttachment = true
        }
    }
    
    func getId() -> String {
        if _id != nil {
            return _id!
        }
        return ""
    }
    
    func getSubject() -> String {
        if _subject != nil {
            return _subject!
        }
        
        return ""
    }
    
    func getDisplayDate() -> String {
        if _dateTimeSent != nil {
            return _dateTimeSent!
        }
        
        return ""
    }
    
    func getDidRead() -> Bool {
        return _didRead
    }
    
    
    func hasAttachment() -> Bool {
        return _hasAttachment
    }
    
    func getMessageType() -> Int {
        return _messageType
    }
    
}
