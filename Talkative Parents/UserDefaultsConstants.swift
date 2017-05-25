//
//  UserDefaultsConstants.swift
//  DonateBlood
//
//  Created by Basavaraj Kalaghatagi on 24/04/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation

import UIKit

class UserDefaultsConstants : NSObject {
    
    let defaults = UserDefaults.standard
    
    
    //check is the user registered
    func isRegistered()-> Bool {
        
        if let IsRegistered: Bool = defaults.bool(forKey: "IsRegistered") as Bool?
        {
            return IsRegistered
        }
        else {
            defaults.set(false, forKey: "IsRegistered")
            return false
            
        }
    }
    
    func setRegistered() {
        defaults.set(true, forKey: "IsRegistered")
    }
    
    func setLogout() {
        defaults.set(false, forKey: "IsRegistered")
    }
    
    func isLoggedIn()-> Bool {
        
        if let IsRegistered: Bool = defaults.bool(forKey: "IsLoggedIn") as Bool?
        {
            return IsRegistered
        }
        else {
            defaults.set(false, forKey: "IsLoggedIn")
            return false
            
        }
    }
    
    func setLogginned() {
        defaults.set(true, forKey: "IsLoggedIn")
    }
    
    func isAdminNotificationEnabled()-> Bool {
        
        if let IsRegistered: Bool = defaults.bool(forKey: "IsAdminNotificationEnabled") as Bool?
        {
            return IsRegistered
        }
        else {
            defaults.set(false, forKey: "IsLoggedIn")
            return false
            
        }
    }
    
    func setAdminNotificationEnabled() {
        defaults.set(true, forKey: "IsAdminNotificationEnabled")
    }
    
    func isProfileCreated()-> Bool {
        
        if let IsRegistered: Bool = defaults.bool(forKey: "IssProfileCreated") as Bool?
        {
            return IsRegistered
        }
        else {
            defaults.set(false, forKey: "IssProfileCreated")
            return false
            
        }
    }
    
    func setProfileCreated() {
        defaults.set(true, forKey: "IssProfileCreated")
    }
    
    func setPushToken(pToken: String) {
        defaults.set(pToken, forKey: "PushToken")
        
    }
    
    func getPushToken() -> String {
        if let myString = defaults.value(forKey: "PushToken") as? String {
            return myString
        }
        return ""
    }
    
    func setProfileCreated1() {
        defaults.set(false, forKey: "IssProfileCreated")
    }
    
    func setPhoneNumber(pPhoneNumber : String) {
        defaults.set(Commons.trim(pValue: pPhoneNumber), forKey: "PhoneNumber")
    }
    
    func getPhoneNumber() -> String {
        if let myString = defaults.value(forKey: "PhoneNumber") as? String {
            return myString
        }
        return ""
    }
    
    func setAuthKey(pPhoneNumber : String) {
        defaults.set(pPhoneNumber, forKey: "User_Auth_Key")
    }
    
    func getAuthKey() -> String {
        if let myString = defaults.value(forKey: "User_Auth_Key") as? String {
            return myString
        }
        return ""
    }
    
    func setUserId(pPhoneNumber : String) {
        defaults.set(pPhoneNumber, forKey: "UserId")
    }
    
    func getUserId() -> String {
        if let myString = defaults.value(forKey: "UserId") as? String {
            return myString
        }
        return ""
    }
    
    func setUserName(pUserName : String) {
        defaults.set(pUserName, forKey: "UserName")
    }
    
    func getUserName() -> String {
        if let myString = defaults.value(forKey: "UserName") as? String {
            return myString
        }
        return ""
    }
    
    
    func setEmailId(pEmailId : String) {
        defaults.set(pEmailId, forKey: "EmailId")
    }
    
    func getEmailId() -> String {
        if let myString = defaults.value(forKey: "EmailId") as? String {
            return myString
        }
        return ""
    }
    
    func setProfileUrl(pProfileUrl : String) {
        defaults.set(pProfileUrl, forKey: "ProfileUrl")
    }
    
    func getProfileUrl() -> String {
        if let myString = defaults.value(forKey: "ProfileUrl") as? String {
            return myString
        }
        return ""
    }
    
    func setIdFromBackEnd(pId : String) {
        defaults.set(pId, forKey: "id")
    }
    
    func getIdFromBackEnd() -> String {
        if let myString = defaults.value(forKey: "id") as? String {
            return myString
        }
        return ""
    }
    
    
    
    
    //    func IsLanguageSelected()-> Bool {
    //
    //        if let IsRegistered: Bool = defaults.boolForKey("IsLanguageSelected") as Bool?
    //        {
    //            return IsRegistered
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "IsLanguageSelected")
    //            return false
    //
    //        }
    //    }
    //
    //    func setLanguageSelected() {
    //        defaults.setBool(true, forKey: "IsLanguageSelected")
    //    }
    //
    //
    //    func IsIntroShow()-> Bool {
    //
    //        if let IsIntroShown: Bool = defaults.boolForKey("IsIntroShown") as Bool?
    //        {
    //            return IsIntroShown
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "IsIntroShown")
    //            return false
    //
    //        }
    //    }
    //
    //    func setIntroShown() {
    //        defaults.setBool(true, forKey: "IsIntroShown")
    //    }
    //
    //
    //    func isPrivateCartCheckedOut()-> Bool {
    //
    //        if let IsRegistered: Bool = defaults.boolForKey("PrivateCartCheckedOut") as Bool?
    //        {
    //            return IsRegistered
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "PrivateCartCheckedOut")
    //            return false
    //
    //        }
    //    }
    //
    //    func setPrivateCartCheckedOut(pBool: Bool) {
    //        defaults.setBool(pBool, forKey: "PrivateCartCheckedOut")
    //    }
    //
    //
    //    func isHouseCartCheckedOut()-> Bool {
    //
    //        if let IsRegistered: Bool = defaults.boolForKey("HouseCartCheckedOut") as Bool?
    //        {
    //            return IsRegistered
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "HouseCartCheckedOut")
    //            return false
    //
    //        }
    //    }
    //
    //    func setHouseCartCheckedOut(pBool: Bool) {
    //        defaults.setBool(pBool, forKey: "HouseCartCheckedOut")
    //    }
    //
    //    //check is the user registered
    //    func isRegisteredWithPhoneNumber()-> Bool {
    //
    //        if let IsRegistered: Bool = defaults.boolForKey("IsRegisteredWithPhoneNumber") as Bool?
    //        {
    //            return IsRegistered
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "IsRegisteredPhoneNumber")
    //            return false
    //
    //        }
    //    }
    //
    //    func setRegisteredWithPhoneNumber() {
    //        defaults.setBool(true, forKey: "IsRegisteredPhoneNumber")
    //    }
    //
    //    func isPushNotificationUpdated() -> Bool {
    //        if let IsRegistered: Bool = defaults.boolForKey("IsPushNotificationUpdated") as Bool?
    //        {
    //            return IsRegistered
    //        }
    //        else {
    //            defaults.setBool(false, forKey: "IsPushNotificationUpdated")
    //            return false
    //            
    //        }
    //    }
    //    
    //    func setPushNotificationUpdated() {
    //        defaults.setBool(true, forKey: "IsPushNotificationUpdated")
    //    }
    
}
