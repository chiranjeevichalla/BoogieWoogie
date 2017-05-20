//
//  ChildService.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class ChildrenService {
    
    class func GetChildren(callback:@escaping (Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        
        let url = Constants.sharedInstance.getChildren()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        
        Alamofire.request(url, method:.get, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        
                        
                        /*var bCountries : [Country] = []
                        for  i in (0..<json.count)
                        {
                            let bContent = json[i].rawString()
                            if let bCountry = Country(JSONString: bContent!) {
                                bCountries.append(bCountry)
                            }
                        }
                        bCountries.sort{ $0._showSequence < $1._showSequence }
 */
                        callback(true)
                        
                        
                    } else {
                        callback(true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback(false)
                }
                
        }
        
    }
    
    
    class func GetChildrenWithChannels(callback:@escaping ([Child], Bool) -> Void) -> Void {
        
        Commons.showIndicator()
        
        
        if !IsConnectedToNetwork() {
            Commons.hideIndicator()
            Commons.showNoNetwork()
            
            return
        }
        
        
        let url = Constants.sharedInstance.getChildrenWithChannels()
        print("url \(url)")
        
        let bHeaders : HTTPHeaders = [
            "authToken" : Constants.sharedInstance._UserDefaults.getAuthKey()
        ]
        print("AuthToken \(Constants.sharedInstance._UserDefaults.getAuthKey())")
        Alamofire.request(url, method:.get, headers: bHeaders)
            .validate(contentType: ["application/json"])
            .responseData { response in
                Commons.hideIndicator()
                
                if response.result.isSuccess {
                    if let data = response.data {
                        //let bResponse = ServiceResponse(JSONString: utf8Text)
                        let json = JSON(data:data)
                        print(json)
                        print("count or length \(json.count)")
                        
                        var bChildrens : [Child] = []
                        
                         for  i in (0..<json.count)
                         {
                         let bContent = json[i].rawString()
                         if let bChild = Child(JSONString: bContent!) {
                         bChildrens.append(bChild)
                         }
                         }
                        
                        
                        callback(bChildrens, true)
                        
                        
                    } else {
                        callback([], true)
                    }
                } else {
                    Commons.showNoNetwork()
                    callback([], false)
                }
                
        }
        
    }
    
}
