//
//  Child.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 19/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import ObjectMapper

class Child : Mappable {
    
    
    var _schoolId : String?
    var _dateOfBirth : String?
    var _schoolLogo : String?
    var _tag : String?
    var _sectionId : String?
    var _channels : [String]?
    var _picture : String?
    var _relationId : String?
    var _firstName : String = ""
    var _stateId : Int?
    var _childId : String?
    var _standardId : String?
    var _gender : Int?
    var _cityId : Int?
    var _countryId : Int?
    var _lastName : String = ""
    
    var _schoolName : String = ""
    var _batchName : String = ""
    var _parentId : String?
    var _schoolToParentChannelId : String?
    
    required init?(map: Map) {
            }
    
    init() {
        
    }
    
    
    func mapping(map: Map) {
        _schoolId       <- map ["SchoolId"]
        _dateOfBirth    <- map ["DateOfBirth"]
        _schoolLogo     <- map ["SchoolLogo"]
        _tag            <- map ["Tag"]
        _sectionId      <- map ["SectionId"]
        _channels       <- map ["Channels"]
        
        _picture        <- map ["Picture"]
        _relationId     <- map ["RelationId"]
        _firstName      <- map ["FirstName"]
        _stateId        <- map ["StateId"]
        _childId        <- map ["ChildId"]
        _standardId     <- map ["StandardId"]
        _gender         <- map ["Gender"]
        _cityId         <- map ["CityId"]
        _countryId      <- map ["CountryId"]
        _lastName       <- map ["LastName"]
        
        if _tag != nil {
            let words = Commons.splitString(pString: _tag!, pSplitBy: "-")
            if words.count >= 2 {
                _schoolName = words[0]
                _batchName = words[1]
            }
        }
        
        if _channels != nil && (_channels?.count)! > 0 && _schoolId != nil{
            for bChannel in _channels! {
//                OneSignal.sendTag(bChannel, value: "1")
                CoreDataManager.sendNotificationTag(pKey: bChannel)
                if bChannel.range(of: _schoolId!) != nil {
                    if bChannel.range(of: "P-") != nil {
                        let bParentId = bChannel.replacingOccurrences(of: "-"+_schoolId!, with: "")
                        _parentId = bParentId.replacingOccurrences(of: "P-", with: "")
                    }
                }
            }
        }
        
        if _schoolId != nil && _parentId != nil {
            _schoolToParentChannelId = "S-\(_schoolId!)-\(_parentId!)"
        }

    }
    
    func getName() -> String {
        return "\(_firstName) \(_lastName)"
    }
    
    func getSchoolLogo() -> String {
        if _schoolLogo != nil {
            return _schoolLogo!
        }
        return ""
    }
    
    func getSchoolName() -> String {
        return _schoolName
    }
    
    func getBatchName() -> String {
        return _batchName
    }
    
    func getTag() -> String {
        if _tag != nil {
            return _tag!
        }
        return ""
    }
    
    func getSchoolId() -> String {
        if _schoolId != nil {
            return _schoolId!
        }
        return ""
    }
    
    func getChildId() -> String {
        if _childId != nil {
            return _childId!
        }
        return ""
    }
    
    func getSectionId() -> String {
        return _sectionId ?? ""
    }
    
    func getStandardId() -> String {
        return _standardId ?? ""
    }
    
    
    func getParentId() -> String {
        return _parentId ?? ""
    }
    
    func getSchoolToParentChannelId() -> String {
        return _schoolToParentChannelId ?? ""
    }
}
