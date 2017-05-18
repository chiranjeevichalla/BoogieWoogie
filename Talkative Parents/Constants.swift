//
//  Constant.swift
//  DonateBlood
//
//  Created by Basavaraj Kalaghatagi on 24/04/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import Alamofire

class Constants: NSObject {
    
    static let sharedInstance = Constants()
    
    //to manager dev or production
    private let isDev = true
    
    let _UserDefaults = UserDefaultsConstants()
    
    //Google Map API Key
    private let _googleMapApiKey = "AIzaSyABc9o4jycAEgfRcbMTLWcteaS_DDDpsZA"
    
    //Google Places API Key
    private let _googlePlacesApiKey = "AIzaSyDOtx3WVSB2LeEBd5enSNwNoy_umTzfX38"
    
    //One Signal details
    private let _oneSignalAppId = "1f4d35d4-77f2-4103-8fd6-8b7b4169c814"
    
    //Dev details   Sample-env-1.kxd3eiwmzj.us-east-1.elasticbeanstalk.com
    //

//    private let _BaseUrlDev = "http://localhost:3000/"
    private let _BaseUrlDev = "http://tpappapi.azurewebsites.net:80/"
    
    private let _BaseAuthUrlDev = "http://tpauthapi.azurewebsites.net:80/"
    
    private let _digitsConsumerKey = "X8wEQ7h2Re89eOcKVNMxizS1w"
    private let _digitsConsumerSecretKey = "lLmmTQo4gc6q3Ks1PIVaBOlyjq7OXYSlcaSoos0mq3BOxPgHHq"
    
    //Prod details
    private let _BaseUrlProd = "http://tpappapi.azurewebsites.net:80/"
    
//    var _user : User = User()
    
    
    private var _pushToken : String = ""
    
    //notifications name
    var _homePageRefeshNotifyId = "com.sys.wepay.refreshHomeTab"
    var _homePageSelectedRowRefreshId = "com.sys.wepay.homePageSelectedRowRefresh"
    
    //Alamofire manager
    var manager = Alamofire.SessionManager.default
    
    var homeNVC : UIViewController?
    
    let firstColor : UIColor = UIColor(hexString: "4DE4B4")!
    let secondColor : UIColor = UIColor(hexString: "38B7DE")!
    
    
    //Services api urls
    private let _loginUrl = "api/Account/Prelogin"
    private let _otpUrl = "api/Account/Validate"
    private let _getCountries = "api/Lookups/GetCountries"
    
    
    //messages
    private let _NoNetworkMessage = "Please check your internet connection"
    
    func getGoogleMapApiKey() -> String {
        return _googleMapApiKey
    }
    
    func getGooglePlacesApiKey() -> String {
        return _googlePlacesApiKey
    }
    
    func setAlamofireManager() {
        //        manager = Alamofire.SessionManager.default
        //        manager.session.configuration.timeoutIntervalForRequest = 1
        //        manager.session.configuration.timeoutIntervalForResource = 1
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 60 // seconds
        configuration.timeoutIntervalForRequest = 60
        
        manager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func getNoNetworkMessage () -> String{
        return _NoNetworkMessage
    }
    
//    func setUser() {
//        self._user._id = self._UserDefaults.getIdFromBackEnd()
//        self._user._profileUrl = self._UserDefaults.getProfileUrl()
//        self._user._phoneNumber = self._UserDefaults.getPhoneNumber()
//        self._user._emailId = self._UserDefaults.getEmailId()
//        self._user._referenceNumber = self._UserDefaults.getUserId()
//        self._user._name = self._UserDefaults.getUserName()
//    }
    
    func getOneSignalAppId() -> String {
        if isDev {
            return _oneSignalAppId
        } else {
            return _oneSignalAppId
        }
    }
    
    func getPushToken() -> String {
        if _pushToken != "" {
            return _pushToken
        }
        return self._UserDefaults.getPushToken()
    }
    
    func setPushToken(pToken:String) {
        _pushToken = pToken
        //save to userdefaults
        self._UserDefaults.setPushToken(pToken: pToken)
    }
    
    func getBaseUrl() -> String {
        if isDev {
            return _BaseUrlDev
        }
        else
        {
            return _BaseUrlProd
        }
    }
    
    func getDigitsConsumerKey() -> String {
        if isDev {
            return _digitsConsumerKey
        } else {
            return _digitsConsumerKey
        }
    }
    
    func getDigitsConsumerSecretKey() -> String {
        if isDev {
            return _digitsConsumerSecretKey
        } else {
            return _digitsConsumerSecretKey
        }
    }
    
    func getLoginUrl() -> String {
        if isDev {
            return "\(self._BaseAuthUrlDev)\(self._loginUrl)"
        } else {
            return "\(self._BaseAuthUrlDev)\(self._loginUrl)"
        }
    }
    
    func getValidateUrl() -> String {
        if isDev {
            return "\(self._BaseAuthUrlDev)\(self._otpUrl)"
        } else {
            return "\(self._BaseAuthUrlDev)\(self._otpUrl)"
        }
    }
    
    //api/Lookups/GetCountries
    func getLookUpsCountryesUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getCountries)"
        } else {
            return "\(self._BaseUrlProd)\(self._getCountries)"
        }
    }
}




