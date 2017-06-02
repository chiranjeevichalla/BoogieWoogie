//
//  File.swift
//  Talkative Parents
//
//  Created by Basaprivate varaj Kalaghatagi on 02/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class SoundingBoard : Mappable {
    
    private var _subject : String?
    private var _categoryName : String?
    private var _categoryKey : String?
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
        _subject                     <- map["subject"]
        _categoryName                     <- map["categoryName"]
        _categoryKey                     <- map["categoryKey"]
        _didRead                     <- map["didRead"]
        _createdDate                     <- map["createdDate"]
        _parentName                     <- map["parentName"]
        _childName                     <- map["childName"]
        _commentsCount                     <- map["commentsCount"]
        _likesCount                     <- map["likesCount"]
        _attachmentCount                     <- map["attachmentCount"]
        _description                   <- map["description"]
        _isStaffReplied                     <- map["isStaffReplied"]
        _isParentReplied                     <- map["isParentReplied"]
        _standardId                     <- map["standardId"]
        _sectionId                     <- map["sectionId"]
    }
    
    func getSubject() -> String {
        return _subject ?? ""
    }
    
    func getCategoryName() -> String {
        return _categoryName ?? ""
    }
    
    func getDate() -> String {
        return _createdDate ?? ""
    }
    
    func getDescription() -> String {
        return _description ?? ""
    }
    
    func getCommentsCount() -> Int {
        return _commentsCount
    }
    
    func getLikesCount() -> Int {
        return _likesCount
    }
    
    func getAttachmentCount() -> Int {
        return _attachmentCount
    }
    
}
