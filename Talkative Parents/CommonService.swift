//
//  CommonService.swift
//  DonateBlood
//
//  Created by Basavaraj Kalaghatagi on 26/04/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import Foundation

import Alamofire

import SystemConfiguration


import ObjectMapper



class ServiceResponse: Mappable {
    
    var _status : Int = 0
    var _message : String = ""
//        var _content : T?
    
    required init?(map: Map) {
        //        mapping(map: map)
    }
    
    func mapping(map: Map) {
        _status <- map["status"]
        _message <- map["message"]
//        _content <- map["content"]
    }
    
}

func IsConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
            SCNetworkReachabilityCreateWithAddress(nil, $0)
        }
    }) else {
        return false
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
        return false
    }
    
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    
    return (isReachable && !needsConnection)
}


class CommonService {
    
    class func checkResponse(pResponse : DataResponse<Data>, callback:@escaping (Bool) -> Void) -> Void {
        switch (pResponse.result) {
        case .success:
            callback(true)
            break
        case .failure(let error):
            print(error._code)
            if error._code == NSURLErrorTimedOut {
                //timeout here
                Commons.showErrorMessage(pMessage: "Request/Response timed out")
                callback(false)
                return
            }
            
            callback(true)
            
            print("\n\nAuth request failed with error:\n \(error)")
            break
        }
    }
    
}
