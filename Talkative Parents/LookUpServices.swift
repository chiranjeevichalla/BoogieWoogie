//
//  LookUpServices.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 18/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import SwiftyJSON


class LookUpService {
    
        class func GetCountries(callback:@escaping ([Country], Bool) -> Void) -> Void {
            
            Commons.showIndicator()
            
            
            if !IsConnectedToNetwork() {
                Commons.hideIndicator()
                Commons.showNoNetwork()
                
                return
            }
            
            
            let url = Constants.sharedInstance.getLookUpsCountryesUrl()
            print("url \(url)")
            
            
            Alamofire.request(url, method:.get)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    Commons.hideIndicator()
                    
                    if response.result.isSuccess {
                        if let data = response.data {
                            //let bResponse = ServiceResponse(JSONString: utf8Text)
                            let json = JSON(data:data)
                            print(json)
                            print("count or length \(json.count)")
                                
                            
                            var bCountries : [Country] = []
                            for  i in (0..<json.count)
                            {
                                let bContent = json[i].rawString()
                                if let bCountry = Country(JSONString: bContent!) {
                                    bCountries.append(bCountry)
                                }
                            }
                            bCountries.sort{ $0._showSequence < $1._showSequence }
                            callback(bCountries, true)
                                
                            
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
