//
//  Comment.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 08/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class Comment : Mappable {
    
    private var _postedDate : String?
    private var _postedBy : String?
    private var _message : String?
    private var _attachment : String?
    private var _postedById : String?
    private var _role : String = "parent"
    
    
    
    private var _firebaseKey: String = ""
    private var _hasAttachment : Bool?
    
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _postedDate                     <- map["postedDate"]
        _postedBy                     <- map["postedBy"]
        _message                     <- map["message"]
        _attachment                     <- map["attachment"]
        if _attachment != nil {
            _hasAttachment = true
        }
        _postedById                     <- map["postedById"]
        _role                     <- map["role"]
    }
    
    func getPostedDate() -> String {
        return _postedDate ?? ""
    }
    
    func setPostedDate(pValue : String) {
        _postedDate = pValue
    }
    
    func getPostedBy() -> String {
        return _postedBy ?? ""
    }
    
    func setPostedBy(pValue : String) {
        _postedBy = pValue
    }
    
    func getMessage() -> String {
        return _message ?? ""
    }
    
    func setMessage(pValue : String) {
        _message = pValue
    }
    
    func getPostedById() -> String {
        return _postedById ?? ""
    }
    
    func setPostedById(pValue : String) {
        _postedById = pValue
    }
    
    func getRole() -> String {
        return _role
    }
    
    func setFirebaseKey(pKey : String) {
        _firebaseKey = pKey
    }
    
    func getFirebaseKey() -> String {
        return _firebaseKey
    }
    
    func hasAttachment() -> Bool {
        return _hasAttachment ?? false
    }
    
    func getAttachment() -> String {
        return _attachment ?? ""
    }
    
    func setAttachment(pValue : String) {
        _attachment = pValue
    }
}

