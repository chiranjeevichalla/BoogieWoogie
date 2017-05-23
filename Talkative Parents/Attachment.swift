//
//  Attachment.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 23/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation

class Attachment : NSObject {
    
    
    var _name : String?
    var _type : String?
    var _url : String?
    var _icon : String = "doc"
    
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
