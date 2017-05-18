//
//  LoginService.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class LoginService {
    
    class func Login(pPhoneNumber: String, pCountryCode : String, callback:@escaping (Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        let bPhoneNumber = "\(pCountryCode)\(pPhoneNumber)"
        
        let parameters: Parameters = [
            "UserName":bPhoneNumber,
            "SpouseInvite":Constants.sharedInstance._UserDefaults.getUserId(),
            "Password" : "",
            "Salutation" : "",
            "FirstName" : "",
            "LastName" : "",
            "Gender" : 0,
            "EmailAddress" : ""
        ]
        
        
        let url = Constants.sharedInstance.getLoginUrl()
        print("url \(url)")
        
        
        Alamofire.request(url, method:.post, parameters:parameters )
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        
                        callback(true)
                        
                        
                    } else {
                        callback( true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback(false)
                }
                
        }
        
    }

    
    class func Validate(pPhoneNumber:String, pOTPCode: String, callback:@escaping (Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        let parameters: Parameters = [
            "UserName":pPhoneNumber,
            "SpouseInvite":"",
            "Password" : pOTPCode,
            "Salutation" : "",
            "FirstName" : "",
            "LastName" : "",
            "Gender" : 0,
            "EmailAddress" : ""
        ]
        
        
        let url = Constants.sharedInstance.getValidateUrl()
        print("url \(url)")
        
        
        Alamofire.request(url, method:.post, parameters:parameters )
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        let bContent = json.rawString()!
                        print("bContent \(bContent)")
                        Constants.sharedInstance._UserDefaults.setPhoneNumber(pPhoneNumber: pPhoneNumber)
                        Constants.sharedInstance._UserDefaults.setAuthKey(pPhoneNumber: bContent)
                        Constants.sharedInstance._UserDefaults.setRegistered()
                        Constants.sharedInstance._UserDefaults.setLogginned()
                        callback(true)
                        
                        
                    } else {
                        callback( true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback(false)
                }
                
        }
        
    }

}
