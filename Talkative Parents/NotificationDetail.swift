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
    var _attachmentsString : String?
    var _icon : String?
    var _id : String?
    
    var _hasAttachment : Bool = false
    var _attachments : [Attachment] = []
    
    
    required init?(map: Map) {
    }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _subject       <- map ["Subject"]
        _message        <- map ["Message"]
        _name           <- map ["Name"]
        _date           <- map ["DateTime"]
        _attachmentsString    <- map ["Attachments"]
        _icon           <- map ["Icon"]
        _id             <- map ["Id"]
        
        if _message != nil {
//            _message = "<p>I am travelling to this and that and this and that </p> <p><a href>https://paynetzuat.atomtech.in/InvoicePayment/MailServlet?data=SUklYNUOCfcDGWYAJF76lA==</a></p>"
            _messageAttributed = try! NSAttributedString(
                data: (_message!.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
//            _messageAttributed = _message!.html2AttributedString
        } else {
            _message = "No Message Found"
            _messageAttributed = try! NSAttributedString(
                data: (_message!.data(using: String.Encoding.unicode, allowLossyConversion: true)!),
                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
        }
        
        if _attachmentsString != nil {
            _hasAttachment = true
            _attachments = Commons.convertStringToAttachments(pString: _attachmentsString!, pSplitBy: ";")
        }
        
        if _date != nil {
            _date = Commons.convertStringToDateFormat(pDate: _date!)
        }

        
    }
    
    func getSubject() -> String {
        if _subject != nil {
            return _subject!
        }
        return ""
    }
    
    func getDisplayDate() -> String {
        if _date != nil {
            return _date!
        }
        return ""
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
