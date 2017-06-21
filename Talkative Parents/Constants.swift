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
    
    
    //One Signal details
    private let _oneSignalAppId = "8c09536b-71d0-4ee5-b085-dfe25387cdb9"
    
    //Dev details   Sample-env-1.kxd3eiwmzj.us-east-1.elasticbeanstalk.com
    //

//    private let _BaseUrlDev = "http://localhost:3000/"
    private let _BaseUrlDev = "http://tpappapi.azurewebsites.net:80/"
    
    private let _BaseAuthUrlDev = "http://tpauthapi.azurewebsites.net:80/"
    
    
    
    private let _imageBasePath = "https://tpupload.blob.core.windows.net/upload/"
    
    //Prod details
    private let _BaseUrlProd = "http://tpappapi.azurewebsites.net:80/"
    
//    var _user : User = User()
    
    
    private var _pushToken : String = ""
    
    //notifications name
    var _homePageRefeshNotifyId = "com.sys.wepay.refreshHomeTab"
    var _homePageSelectedRowRefreshId = "com.sys.wepay.homePageSelectedRowRefresh"
    
    //Alamofire manager
    var manager = Alamofire.SessionManager.default
    
    var _child = Child()
    var _parent = ParentProfile()
    
    let firstColor : UIColor = UIColor(hexString: "4DE4B4")!
    let secondColor : UIColor = UIColor(hexString: "38B7DE")!
    
    let barColor : UIColor = UIColor(red: 2/255, green: 150/255, blue: 154/255, alpha: 1.0)
    
    //Services api urls
    //services api auth
    private let _loginUrl = "api/Account/Prelogin"
    private let _otpUrl = "api/Account/Validate"
    
    
    //services api children
    private let _getChildren = "api/Child/GetChildren"
    private let _getChildrenWithChannels = "api/Child/GetChildrenWithChannels"
    private let _getSchoolNotifications = "api/AppUser/GetSchoolNotifications"
    private let _getAdminNotifications = "api/AppUser/GetAdminNotifications"
    private let _getNotificationDetails = "api/AppUser/GetNotificationDetails"
    private let _getProfile = "api/AppUser/GetProfile"
    
    //services api lookups
    private let _getCountries = "api/Lookups/GetCountries"
    
    //services api storage
    private let _getUploadFile = "api/Storage/UploadFile"
    
    
    //messages
    private let _NoNetworkMessage = "Please check your internet connection"
    
    
    
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
    
    
    //MARK: api/Auth services
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
    
    //MARK: api/Children services
    func getChildren() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getChildren)"
        } else {
            return "\(self._BaseUrlProd)\(self._getChildren)"
        }
    }
    
    func getChildrenWithChannels() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getChildrenWithChannels)"
        } else {
            return "\(self._BaseUrlProd)\(self._getChildrenWithChannels)"
        }
    }
    
    //MARK: App Services
    func getSchoolNotifications() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getSchoolNotifications)"
        } else {
            return "\(self._BaseUrlProd)\(self._getSchoolNotifications)"
        }
    }

    func getAdminNotificationUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getAdminNotifications)"
        } else {
            return "\(self._BaseUrlProd)\(self._getAdminNotifications)"
        }
    }

    
    func getNotificationDetail() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getNotificationDetails)"
        } else {
            return "\(self._BaseUrlProd)\(self._getNotificationDetails)"
        }
    }
    
    func getProfile() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getProfile)"
        } else {
            return "\(self._BaseUrlProd)\(self._getProfile)"
        }

    }
    
    //MARK: //api/Lookups services
    func getLookUpsCountryesUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getCountries)"
        } else {
            return "\(self._BaseUrlProd)\(self._getCountries)"
        }
    }
    
    
    //MARK: GetImage BAse Path
    func getImageBasePath() ->String {
        return _imageBasePath
    }
    
    //MARK: STORAGE api
    func getUploadFileUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getUploadFile)"
        } else {
            return "\(self._BaseUrlProd)\(self._getUploadFile)"
        }
    }
}




