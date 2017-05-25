//
//  AppService.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 20/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class AppService {
    
    class func GetSchoolNotifications(pSchoolId : String, pFromPageNumber: Int, callback:@escaping ([Notification],Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        
        let url = Constants.sharedInstance.getSchoolNotifications()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        let bParameters: Parameters = [
            "schoolId":pSchoolId,
            "page": pFromPageNumber,
            "pageSize":20
            
        ]

        
        
        Alamofire.request(url, method:.get, parameters: bParameters, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        
                        
                         var bNotifications : [Notification] = []
                         for  i in (0..<json.count)
                         {
                             let bContent = json[i].rawString()
                             if let bNotification = Notification(JSONString: bContent!) {
                                bNotification._messageType = 2
                             bNotifications.append(bNotification)
                         }
                         }
//                         bCountries.sort{ $0._showSequence < $1._showSequence }
                        
                        callback(bNotifications, true)
                        
                        
                    } else {
                        callback([],true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback([], false)
                }
                
        }
        
    }
    
    class func GetAdminNotifications(pSchoolId : String, pFromPageNumber: Int, callback:@escaping ([Notification],Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        
        let url = Constants.sharedInstance.getAdminNotificationUrl()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        let bParameters: Parameters = [
//            "schoolId":pSchoolId,
            "page": pFromPageNumber,
            "pageSize":20
            
        ]
        
        
        
        Alamofire.request(url, method:.get, parameters: bParameters, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        
                        
                        var bNotifications : [Notification] = []
                        for  i in (0..<json.count)
                        {
                            let bContent = json[i].rawString()
                            if let bNotification = Notification(JSONString: bContent!) {
                                bNotification._messageType = 1
                                bNotifications.append(bNotification)
                            }
                        }
                        //                         bCountries.sort{ $0._showSequence < $1._showSequence }
                        
                        callback(bNotifications, true)
                        
                        
                    } else {
                        callback([],true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback([], false)
                }
                
        }
        
    }

    
    class func GetNotificationDetail(pNotificationId : String, pMessageType: Int, callback:@escaping (NotificationDetail?, Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        
        let url = Constants.sharedInstance.getNotificationDetail()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        let bParameters: Parameters = [
            "id":pNotificationId,
            "messageType":pMessageType
            
        ]
        
        
        
        Alamofire.request(url, method:.get, parameters: bParameters, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        let bContent = json.rawString()
                        let bNotification = NotificationDetail(JSONString: bContent!)
                        
                        
//                        var bNotifications : [Notification] = []
//                        for  i in (0..<json.count)
//                        {
//                            let bContent = json[i].rawString()
//                            if let bNotification = Notification(JSONString: bContent!) {
//                                bNotification._messageType = 2
//                                bNotifications.append(bNotification)
//                            }
//                        }
                        //                         bCountries.sort{ $0._showSequence < $1._showSequence }
                        
                        callback(bNotification, true)
                        
                        
                    } else {
                        callback(nil, false)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback(nil, false)
                }
                
        }
        
    }

}
