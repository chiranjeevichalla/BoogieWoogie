//
//  ParentProfile.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 05/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class ParentProfile : Mappable {
    
    private var _emailAddress : String?
    private var _firstName : String?
    private var _salutation : String?
    private var _gender : Int? //1 female, 2 male
    private var _lastName : String?
    private var _lastlogin : String?
    private var _isPorfilePicUploaded : String?
    private var _isOffersOptedIn : String?
    private var _middleName : String?
    private var _id : String?
    
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _emailAddress                     <- map["EmailAddress"]
        _firstName                     <- map["FirstName"]
        _salutation                     <- map["Salutation"]
        _gender                     <- map["Gender"]
        _lastName                     <- map["LastName"]
        _lastlogin                     <- map["LastLogin"]
        _isPorfilePicUploaded                     <- map["IsProfilePicUploaded"]
        _isOffersOptedIn                     <- map["IsOffersOptedIn"]
        _middleName                     <- map["MiddleName"]
        _id                     <- map["Id"]
    }
    
    func getId() -> String {
        return _id ?? ""
    }
    
    func getFirstName() -> String {
        return _firstName ?? ""
    }
    
    func getMiddleName() -> String {
        return _middleName ?? ""
    }
    
    func getLastName() -> String {
        return _lastName ?? ""
    }
    
    func getName() -> String {
        return "\(getFirstName()) \(getMiddleName()) \(getLastName())"
    }
    
    
    
}
