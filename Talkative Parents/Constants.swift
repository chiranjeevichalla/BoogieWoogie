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
    private let _BaseUrlDev = "http://tpappapi.azurewebsites.net/"
    
    private let _BaseAuthUrlDev = "https://tpauthapi.azurewebsites.net:80/"
    
    private let _digitsConsumerKey = "X8wEQ7h2Re89eOcKVNMxizS1w"
    private let _digitsConsumerSecretKey = "lLmmTQo4gc6q3Ks1PIVaBOlyjq7OXYSlcaSoos0mq3BOxPgHHq"
    
    //Prod details
    private let _BaseUrlProd = "http://sample-env.qhbnxmw4sq.us-east-1.elasticbeanstalk.com/"
    
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
    private let _loginUrl = "api/login"
    private let _validatePhoneNumber = "login/validatePhonenumber"
    private let _createProfileUrl = "User/CreateProfile"
    private let _updateProfileUrl = "api/addUserDetails"
    private let _updateProfilePicUrl = "User/UpdateProfilePic"
    private let _scanBillUrl = "Bill/Scanimages"
    private let _updateBill = "Bill/Savebill"
    private let _getBillDetailsUrl = "Bill/GetBillDetails"
    private let _getAllBillDetailsUrl = "billaction/getAllBillDetails"
    private let _getAddbillDetailsUrl = "billaction/addBillDetails"
    private let _getUpdateBillStatusUrl = "billaction/updateBillStatus"
    private let _getCompleteBillDetails = "billaction/getBillDetails"
    private let _getUpdatePaymentStatusUrl = "billaction/updatePaymentStatus"
    private let _getAllBillContactsUrl = "billaction/getAllBillContacts"
    private let _getPayeeDetailsUrl = "billaction/getPayeeDetails"
    private let _getPushTokenUrl = "api/updateToken"
    private let _scanBillImage1Url = "billaction/scanImages1"
    private let _getClosedBillsUrl = "billaction/getClosedBills"
    private let _getSendReminderUrl = "billaction/sendReminder"
    
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
            return "\(self._BaseUrlDev)\(self._loginUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._loginUrl)"
        }
    }
    
    
    func getValidatePhoneNumberUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._validatePhoneNumber)"
        } else {
            return "\(self._BaseUrlProd)\(self._validatePhoneNumber)"
        }
    }
    
    func getCreateProfileUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._createProfileUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._createProfileUrl)"
        }
    }
    
    func getPushTokenUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getPushTokenUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getPushTokenUrl)"
        }
    }
    
    func getUpdateProfileUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._updateProfileUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._updateProfileUrl)"
        }
    }
    
    func getUpdateProfilePicUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._updateProfilePicUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._updateProfilePicUrl)"
        }
    }
    
    func getScanBillUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._scanBillUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._scanBillUrl)"
        }
    }
    
    func getUpdateBillUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._updateBill)"
        } else {
            return "\(self._BaseUrlProd)\(self._updateBill)"
        }
    }
    
    func getBillDetailsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getBillDetailsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getBillDetailsUrl)"
        }
    }
    
    func getAllBillDetailsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getAllBillDetailsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getAllBillDetailsUrl)"
        }
    }
    
    func getAddBillDetailsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getAddbillDetailsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getAddbillDetailsUrl)"
        }
    }
    
    func getUpdateBillStatusUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getUpdateBillStatusUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getUpdateBillStatusUrl)"
        }
    }
    
    func getCompleteBillDetails() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getCompleteBillDetails)"
        } else {
            return "\(self._BaseUrlProd)\(self._getCompleteBillDetails)"
        }
    }
    
    func getUpdatePaymentStatusUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getUpdatePaymentStatusUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getUpdatePaymentStatusUrl)"
        }
    }
    
    func getAllBillContactsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getAllBillContactsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getAllBillContactsUrl)"
        }
    }
    
    func getPayeeDetailsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getPayeeDetailsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getPayeeDetailsUrl)"
        }
    }
    
    func getClosedBillsUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getClosedBillsUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getClosedBillsUrl)"
        }
    }
    
    func getScanBillImage1Url() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._scanBillImage1Url)"
        } else {
            return "\(self._BaseUrlProd)\(self._scanBillImage1Url)"
        }
    }
    
    func getSendReminderUrl() -> String {
        if isDev {
            return "\(self._BaseUrlDev)\(self._getSendReminderUrl)"
        } else {
            return "\(self._BaseUrlProd)\(self._getSendReminderUrl)"
        }
    }
}




