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
    
}
