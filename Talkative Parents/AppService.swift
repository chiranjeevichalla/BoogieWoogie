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
    
    class func GetSchoolNotifications(pSchoolId : String, pPageNumber: Int, callback:@escaping ([Notification],Bool) -> Void) -> Void {
        
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
            "page": pPageNumber,
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
//                        print(json)
                        print("school notifications count or length \(json.count)")
                        
                        
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
    
    class func GetAdminNotifications(pSchoolId : String, pPageNumber: Int, callback:@escaping ([Notification],Bool) -> Void) -> Void {
        
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
            "page": pPageNumber,
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
    
    class func GetProfile(callback:@escaping (Bool) -> Void) -> Void {
        
//        Commons.showIndicator()
//        
//        
//        if !IsConnectedToNetwork() {
//            Commons.hideIndicator()
//            Commons.showNoNetwork()
//            
//            return
//        }
        
        
        let url = Constants.sharedInstance.getProfile()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        
        
        
        Alamofire.request(url, method:.get, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
//                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        let bContent = json.rawString()
                        let bParent = ParentProfile(JSONString: bContent!)
                        Constants.sharedInstance._parent = bParent!
                        callback( true)
                        
                        
                    } else {
                        callback( false)
                    }
                } else {
//                    Commons.showNoNetwork()
                    callback( false)
                }
                
        }
        
    }
    
    class func UploadFile(pFileName : String, pImage : UIImage, pIsProfile : Bool, callback:@escaping (String, Bool) -> Void)
    {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
//        let bFileName = ProcessInfo.processInfo.globallyUniqueString
        var bFileSize = ""
        var bBase64String = ""
        var bFileName = "\(pFileName)"
        
        if pIsProfile {
            let bData = UIImagePNGRepresentation(pImage)
            bFileSize = "\(bData?.count)"
            bBase64String = (bData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))!
            
            bFileName = "\(pFileName).png"
        } else {
            let bData = UIImageJPEGRepresentation(pImage, 0.9)
            bFileSize = "\(bData?.count)"
            bBase64String = (bData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0)))!
            bFileName = "\(pFileName).jpg"
        }
        // NSData *imagedata = UIImagePNGRepresentation(mImage.image);
        

        let url = Constants.sharedInstance.getUploadFileUrl()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        let bParameters: Parameters = [
            "filetype": "images",
            "filename": bFileName,
            "filesize": bFileSize,
            "base64": bBase64String,
            "isProfile": pIsProfile,
            "profileId": "d3aaa86a-4c61-4c60-91dd-9201faa71baa" //Constants.sharedInstance._child.getParentId()
            
        ]
        
        
        
        Alamofire.request(url, method:.post, parameters: bParameters, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        if let bContent = json.rawString() {
                            print(bContent)
                            
                            callback(bContent, true)
                        } else {
                            callback("", false)
                        }
                        
                        
                    } else {
                        callback("", false)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback("", false)
                }
                
        }
    }

}
