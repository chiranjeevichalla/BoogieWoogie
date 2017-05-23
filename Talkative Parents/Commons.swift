//
//  Commons.swift
//  DonateBlood
//
//  Created by Basavaraj Kalaghatagi on 24/04/17.
//  Copyright © 2017 SGS. All rights reserved.
//



import Foundation
import UIKit

//import SwiftyDrop
import RKDropdownAlert
import ChameleonFramework
import Kingfisher

//import Eureka

//public final class LocationRow : SelectorRow<PushSelectorCell<Address1>, LocationMapViewController>, RowType {
//    public required init(tag: String?) {
//        super.init(tag: tag)
//        presentationMode = .show(controllerProvider: ControllerProvider.callback { return LocationMapViewController(){ _ in } }, onDismiss: { vc in _ = vc.navigationController?.popViewController(animated: true) })
//        
//        displayValueFor = {
//            guard let place = $0 else { return "" }
////            let fmt = NumberFormatter()
////            fmt.maximumFractionDigits = 4
////            fmt.minimumFractionDigits = 4
////            let latitude = fmt.string(from: NSNumber(value: location.coordinate.latitude))!
////            let longitude = fmt.string(from: NSNumber(value: location.coordinate.longitude))!
//            return place.getAddress()
//        }
//    }
//}


class Commons {
    class func showIndicator() {
        LilithProgressHUD.show()
    }
    
    class func hideIndicator() {
        LilithProgressHUD.hide()
    }
    
    class func showNoNetwork() {
        //        Drop.down(Constants.sharedInstance.getNoNetworkMessage(), state: .warning)
        //        Drop.down(Constants.sharedInstance.getNoNetworkMessage(), state: .warning, duration: 3.0, action: nil)
        RKDropdownAlert.title("Seems No Network", message: Constants.sharedInstance.getNoNetworkMessage(), backgroundColor: UIColor.white, textColor: Constants.sharedInstance.secondColor, time: 3)
//        RKDropdownAlert.title("Seems No Network", message: Constants.sharedInstance.getNoNetworkMessage(), time: 3)
        
    }
    
    class func showErrorMessage(pMessage: String) {
        
        RKDropdownAlert.title("", message:pMessage, backgroundColor: UIColor.white, textColor: Constants.sharedInstance.secondColor, time: 4)
//        RKDropdownAlert.title("", message: pMessage, time: 4)
    }
    
    //Validate the email address
    class func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
    
    // Remove all special characters from the given string
    class func trim(pValue: String) -> String {
        var bValue = pValue
        bValue = bValue.folding(options: String.CompareOptions.diacriticInsensitive, locale: nil)
        bValue = bValue.replacingOccurrences(of: " ", with: "")
        bValue = bValue.replacingOccurrences(of: "-", with: "")
        bValue = bValue.replacingOccurrences(of: "(", with: "")
        bValue = bValue.replacingOccurrences(of: ")", with: "")
        return bValue
    }
    
    class func convertStringToDateFormat(pDate: String) -> String {
        let words = pDate.components(separatedBy: ".")
        let dateFormatter = DateFormatter()
        //        2017-02-07T00:00:00.000Z
        //        print(words[0])
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"  //  "dd-mm-yyyy" //Your date format
        let date = dateFormatter.date(from: words[0])
        //
        //
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.day, .month, .year, .hour, .minute], from: date!)
        
        let df = DateFormatter()
        df.dateFormat="MMM"
        let month = df.string(from: date!)
        let day = components.day
        var bDay = "\(day!)"
        if day! < 10 {
            bDay = "0\(day!)"
        }
        let year = components.year
        var hour = components.hour
        let minute = components.minute
        var bTimeDay = "AM"
        if hour! > 12 {
            bTimeDay = "PM"
            hour = hour! - 12
        }
        var hourString = "\(hour!)"
        if hour! < 10 {
            hourString = "0\(hour!)"
        }
        var minuteString = "\(minute!)"
        if minute! < 10 {
            minuteString = "0\(minute!)"
        }
        return "\(bDay) \(month) \(year!) \(hourString):\(minuteString) \(bTimeDay)"
        
    }
    
   
    
    class func convertDateToString(pDate: Date) -> (String) {
        
//        let words = pDate.components(separatedBy: ".")
        let dateFormatter = DateFormatter()
        //        2017-02-07T00:00:00.000Z
        //        print(words[0])
        
        dateFormatter.dateFormat = "yyyy-MM-dd"  //  "dd-mm-yyyy" //Your date format
        let date = pDate
        
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.day, .month, .year], from: date)
        
        
        let day = components.day
        var bDay = "\(day!)"
        if day! < 10 {
            bDay = "0\(day!)"
        }
        let month = components.month
        var bMonth = "\(month!)"
        if month! < 10 {
            bMonth = "0\(month!)"
        }
        
        let year = components.year
        
        //        return (bDay, "\(month)", "\(year)")
        return "\(year!)-\(bMonth)-\(bDay)"
    }
    
    class func openURL(scheme: String) {
        if let url = URL(string: scheme) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                                            print("Open \(scheme): \(success)")
                })
            } else {
                let success = UIApplication.shared.openURL(url)
                print("Open \(scheme): \(success)")
            }
        }
    }
    
    class func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width:size.width * heightRatio , height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    // Convert
    class func ConvertTo2Decimal(pValue : Double) -> Double {
        let bValue = Double(String(format: "%.2f", arguments: [pValue]))
        if bValue != nil {
            return bValue!
        } else {
            return pValue
        }
    }
    
    // Convert
    class func ConvertTo2DecimalString(pValue : String) -> String {
        return String(format: "%.2f", pValue)
    }
    
    class func ConvertTo2DecimalString1(pValue : Double) -> String {
        return String(format: "%.2f", pValue)
    }
    
    class func isFileExists(pFileName: String) -> (Bool, String) {
        let fileNameToDelete = pFileName
        var filePath = ""
        
        // Fine documents directory on device
        let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
        
        if dirs.count > 0 {
            let dir = dirs[0] //documents directory
            filePath = dir.appendingFormat("/" + fileNameToDelete)
            print("Local path = \(filePath)")
        } else {
            print("Could not find local directory to store file")
            return (false , "")
        }
        
        
        let fileManager = FileManager.default
        
        // Check if file exists
        if fileManager.fileExists(atPath: filePath) {
            return (true, filePath)
        } else {
            return (false, "")
        }
    }
    
    class func verifyUrl (urlString: String?) -> Bool {
        //Check for nil
        if let urlString = urlString {
            // create NSURL instance
            if let url = NSURL(string: urlString) {
                // check if your application can open the NSURL instance
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    class func setNavigationDetails(navigationController : UINavigationController?) {
        if let _ = navigationController {
            let firstColor = Constants.sharedInstance.firstColor
            let secondColor = Constants.sharedInstance.secondColor
            navigationController?.navigationBar.barTintColor = UIColor(gradientStyle: UIGradientStyle.leftToRight, withFrame: (navigationController?.navigationBar.frame)!, andColors: [firstColor, secondColor])
            navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
            navigationController?.navigationBar.isTranslucent = false
            
//            var navigationBarAppearace = UINavigationBar.appearance()

        }
    }
    
    class func setNavigationBarDetails(navigationBar : UINavigationBar) {
        let firstColor = Constants.sharedInstance.firstColor
        let secondColor = Constants.sharedInstance.secondColor
        navigationBar.barTintColor = UIColor(gradientStyle: UIGradientStyle.leftToRight, withFrame: (navigationBar.frame), andColors: [firstColor, secondColor])
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        navigationBar.isTranslucent = false
    }
    
    class func setSegmentColor(segmentController : UISegmentedControl) {
        let firstColor = Constants.sharedInstance.firstColor
        let secondColor = Constants.sharedInstance.secondColor
        var frame = segmentController.frame
        frame.size = segmentController.bounds.size
        segmentController.backgroundColor = UIColor(gradientStyle: UIGradientStyle.leftToRight, withFrame: frame, andColors: [firstColor, secondColor])
        segmentController.layer.borderColor = UIColor(gradientStyle: UIGradientStyle.leftToRight, withFrame: frame, andColors: [firstColor, secondColor]).cgColor
        
        segmentController.layer.cornerRadius = 0
        segmentController.layer.borderWidth = 3
    }
    
    class func isSameNumber(pPhoneNumber: String) -> Bool {
        var bIsSameNumber = false
        if Constants.sharedInstance._UserDefaults.getPhoneNumber().range(of: pPhoneNumber) != nil {
            bIsSameNumber = true
        }
        return bIsSameNumber
    }
    
    class func applyCommonBtnRadius(pBtn : UIButton) {6
        pBtn.layer.cornerRadius = 5
    }
    
    class func setImage(pImage: UIImageView, pUrl : String) {
        if pImage != nil {
            if let url = URL(string: "\(Constants.sharedInstance.getImageBasePath())\(pUrl)") {
                pImage.kf.setImage(with: url)
            }
        }
    }
    
    
    class func splitString(pString : String, pSplitBy : String) -> [String] {
        let words = pString.components(separatedBy: pSplitBy)
        return words
    }
    
    class func convertStringToAttachments (pString : String, pSplitBy : String) -> [Attachment] {
        var bAttachments : [Attachment] = []
        let words = Commons.splitString(pString: pString, pSplitBy: pSplitBy)
        for bWord in words {
            let bAttachment = Attachment()
            bAttachment._url = bWord
            let bWords = Commons.splitString(pString: bWord, pSplitBy: "-")
            let bName = bWords[bWords.count-1]
            let bNameWords = Commons.splitString(pString: bName, pSplitBy: ".")
            bAttachment._type = bNameWords[bNameWords.count-1]
            bAttachment._name = bNameWords[0]
            bAttachments.append(bAttachment)
        }
        return bAttachments
    }
    
    
    //    class func ConvertJSONToString(pData : NSDictionary, callback (String) -> Void) -> Void {
    //        let jsonData: NSDate = JSONSerialization.data(withJSONObject: pData, options: .prettyPrinted)
    //
    //        var jsonData: NSData = JSONSerialization.dataWithJSONObject(pData, options: JSONSerialization.WritingOptions.PrettyPrinted, error: &error)!
    //            if error == nil {
    //
    //            let bString = NSString(data: jsonData, encoding: NSUTF8StringEncoding)! as String
    //                callback(bString)
    //        }
    //    }
    //    
}



