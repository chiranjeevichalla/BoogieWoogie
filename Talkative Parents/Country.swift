//
//  Country.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import ObjectMapper

class Country : Mappable {
    
    var _id : Int?
    var _name : String?
    var _prefix : String?
    var _showSequence : Int = 500;
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _id                     <- map["Id"]
        _name                   <- map ["Name"]
        _prefix                 <- map ["Prefix"]
        _showSequence           <- map["ShowSequence"]
    }
    
    func getId() -> Int {
        if _id != nil {
            return _id!
        }
        return 0
    }
    
    func getName() -> String {
        if _name != nil {
            return _name!
        }
        return ""
    }
    
    func getPrefix() -> String {
        if _prefix != nil {
            return _prefix!
        }
        return ""
    }
    
}

