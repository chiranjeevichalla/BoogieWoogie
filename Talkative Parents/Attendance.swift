//
//  Attendance.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 01/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class Attendance : Mappable {
    
    
    var _category : String?
    var _date : String?
    var _isPresent : String?
    var _message : String?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _category        <- map ["category"]
        _date            <- map ["date"]
        _isPresent       <- map ["isPresent"]
        _message         <- map ["message"]
    }
    
    
    func getCategory() -> String {
        return _category ?? ""
    }
    
    func getDate() -> String {
        return _date ?? ""
    }
    
    func isPresent() -> Bool {
        if _isPresent != nil {
            if _isPresent == "1" {
                return true
            }
        }
        return false
    }
    
    func getMessage() -> String {
        return _message ?? ""
    }
    
}
