//
//  Attachment.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 23/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

enum Doctype: String {
    case doc = "doc"
    case pdf = "pdf"
    case image = "image"
    case excel = "excel"
    case media = "media"
}

class Attachment : NSObject {
    
    
    var _name : String?
    var _type : String?
    var _url : String?
    var _icon : String = "doc"
    var _docType : Doctype?
    var _isAttached : Bool = false
    
    override init() {
        
    }
    
    func getName() -> String {
        if _name != nil {
            return _name!
        }
        return ""
    }
    
    func getType() -> String {
        if _type != nil {
            return _type!
        }
        return ""
    }
    
    func getUrl() -> String {
        if _url != nil {
            return _url!
        }
        return ""
    }
    
}

class AttachmentFirebase : Mappable {
    
    private var _subject : String?
    private var _categoryName : String?
    private var _categoryKey : String? //firebasekey
    private var _didRead : Bool = false
    private var _createdDate : String?
    private var _parentName : String?
    private var _childName : String?
    private var _commentsCount : Int = 0
    private var _likesCount : Int = 0
    private var _attachmentCount : Int = 0
    private var _description : String?
    private var _isStaffReplied : Bool = false
    private var _isParentReplied : Bool = false
    private var _standardId : String?
    private var _sectionId : String?
 
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {
        _subject                 <- map["subject"]
        _categoryName                 <- map["categoryName"]
        _categoryKey                 <- map["categoryKey"]
        _didRead                 <- map["didRead"]
        _createdDate                 <- map["createdDate"]
        _parentName                 <- map["parentName"]
        _childName                 <- map["childName"]
        _commentsCount                 <- map["commentsCount"]
        _likesCount                 <- map["likesCount"]
        _attachmentCount                 <- map["attachmentCount"]
        _description                 <- map["description"]
        _isStaffReplied                 <- map["isStaffReplied"]
        _isParentReplied                 <- map["isParentReplied"]
        _standardId                 <- map["standardId"]
        _sectionId                 <- map["_sectionId"]
    }

}
