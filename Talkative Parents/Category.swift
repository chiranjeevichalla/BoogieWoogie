//
//  Category.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 03/06/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class Category1 : NSObject {
    var _name : String?
    var _status : String?
    var _key : String = ""
    
    override init() {
        
    }

    
    func getName() -> String {
        return _name ?? ""
    }
    
    func getKey() -> String {
        return _key
    }
}

class Category : Mappable {
    
    
    var _name : String?
    var _status : String?
    var _key : String = ""
    
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        
        _name                   <- map ["category_name"]
        _status                 <- map ["responseStatus"]
        
    }
    
    
    
    func getName() -> String {
        if _name != nil {
            return _name!
        }
        return ""
    }
    
    func getKey() -> String {
        return _key
    }
    
    
    
}
