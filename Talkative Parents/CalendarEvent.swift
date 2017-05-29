//
//  CalendarEvent.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 29/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class CalendarEvent : Mappable {
    
    
    var _title : String?
    var _type : String?
    var _desc : String?
    var _startDateStr : String?
    var _startDate : Date?
    var _endDateStr : String?
    var _endDate : Date?
    var _sectionId : String?
    var _sectionName : String?
    var _standardId : String?
    var _standardName : String?
    
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        _title        <- map ["event_title"]
        _type         <- map ["event_type"]
        _desc         <- map ["event_type"]
        _startDateStr   <- map ["event_start_date"]
        _endDateStr     <- map ["event_end_date"]
        _sectionId      <- map ["sectionId"]
        _sectionName    <- map ["sectionName"]
        _standardId     <- map ["standardId"]
        _standardName   <- map ["standardName"]
        
        if _startDateStr != nil && _startDateStr != "" {
            _startDate = Commons.convertStringToDateFormat1(pDate: _startDateStr!)
            _startDateStr = Commons.convertStringToDateFormat2(pDate: _startDateStr!)
        }
        
        if _endDateStr != nil && _endDateStr != "" {
            _endDate = Commons.convertStringToDateFormat1(pDate: _endDateStr!)
        }
    }
    
    func getResultDynamic(pData : Any?, pValue : Any) -> Any {
        return pData ?? pValue
    }
    
    func getTitle() -> String {
//        return getResultDynamic(pData: _title, pValue: "")
        return _title ?? ""
    }
    
    func getStartDate() -> Date {
        return _startDate!
    }
    
    func getEndDate() -> Date {
        return _endDate!
    }
    
    func getDisplayDate() -> String {
        return _startDateStr ?? ""
    }
 
}
