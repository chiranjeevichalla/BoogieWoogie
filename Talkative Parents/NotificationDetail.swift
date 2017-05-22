//
//  NotificationDetail.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 22/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class NotificationDetail : Mappable {
    
    
    
    var _subject : String?
    var _message : String?
    var _messageAttributed : NSAttributedString?
    var _name : String?
    var _date : String?
    var _attachments : String?
    var _icon : String?
    var _id : String?
    
    
    required init?(map: Map) {
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _subject       <- map ["Subject"]
        _message        <- map ["Message"]
        _name           <- map ["Name"]
        _date           <- map ["DateTime"]
        _attachments    <- map ["Attachments"]
        _icon           <- map ["Icon"]
        _id             <- map ["Id"]
        if _message != nil {
            _messageAttributed = _message!.html2AttributedString
        }
        
    }
    
}

extension String {
    
    
    var html2AttributedString: NSAttributedString? {
        guard
            let data = data(using: String.Encoding.utf8)
            else { return nil }
        do {
            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:String.Encoding.utf8], documentAttributes: nil)
        } catch let error as NSError {
            print(error.localizedDescription)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}
