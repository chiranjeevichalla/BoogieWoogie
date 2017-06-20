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
import Alamofire

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
    
    class func getCurrentDateToString() -> String {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from:date as Date)
        return dateString
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
    
    class func convertStringToDateFormat2(pDate: String) -> String {
        let words = pDate.components(separatedBy: ".")
        let dateFormatter = DateFormatter()
        //        2017-02-07T00:00:00.000Z
        //        print(words[0])
        
        dateFormatter.dateFormat = "yyyy-MM-dd"  //  "dd-mm-yyyy" //Your date format
        let date = dateFormatter.date(from: words[0])
        //
        //
        let calendar = Calendar.autoupdatingCurrent
        let components = calendar.dateComponents([.day, .month, .year], from: date!)
        
        let df = DateFormatter()
        df.dateFormat="MMM"
        let month = df.string(from: date!)
        
        let df1 = DateFormatter()
        df1.dateFormat="EEEE"
        let dayString = df1.string(from: date!)
        
        let day = components.day
        var bDay = "\(day!)"
        if day! < 10 {
            bDay = "0\(day!)"
        }
        let year = components.year
        var hour = components.hour
        let minute = components.minute
        
        return "\(dayString), \(bDay) \(month) \(year!)"
        
    }
    
    class func convertStringToDateFormat1(pDate: String) -> Date {
//        let words = pDate.components(separatedBy: ".")
        let dateFormatter = DateFormatter()
        //        2017-02-07T00:00:00.000Z
        //        print(words[0])
        
        dateFormatter.dateFormat = "yyyy-MM-dd"  //  "dd-mm-yyyy" //Your date format
        let date = dateFormatter.date(from: pDate)
        return date!
        
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
    
    class func applyCommonBtnRadius(pBtn : UIButton) {
        pBtn.layer.cornerRadius = 5
    }
    
    class func setImage(pImage: UIImageView, pUrl : String) {
        if pImage != nil {
            if let url = URL(string: "\(Constants.sharedInstance.getImageBasePath())\(pUrl)") {
                pImage.kf.setImage(with: url)
            }
        }
    }
    
    class func constructUrl(pUrl: String) -> URL? {
        let urlString = pUrl.replacingOccurrences(of: " ", with: "%20")
        
        return URL(string: "\(Constants.sharedInstance.getImageBasePath())\(urlString)")
    }
    
    class func constructNSUrl(pUrl: String) -> NSURL? {
        let urlString = pUrl.replacingOccurrences(of: " ", with: "%20")
        let bPath = "\(Constants.sharedInstance.getImageBasePath())\(urlString)"
        print(bPath)
        return NSURL(string: bPath)
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
            bAttachment._docType = Commons.getDocType(pType: bAttachment._type!.lowercased())
            bAttachments.append(bAttachment)
        }
        return bAttachments
    }
    
    class func convertStringToAttachment (pString : String) -> Attachment {
        
            var bString = pString
            bString = bString.replacingOccurrences(of: Constants.sharedInstance.getImageBasePath(), with: "")
            let bAttachment = Attachment()
            bAttachment._url = bString
            let bWords = Commons.splitString(pString: bString, pSplitBy: "-")
            let bName = bWords[bWords.count-1]
            let bNameWords = Commons.splitString(pString: bName, pSplitBy: ".")
            bAttachment._type = bNameWords[bNameWords.count-1]
            bAttachment._name = bNameWords[0]
            bAttachment._docType = Commons.getDocType(pType: bAttachment._type!.lowercased())
            return bAttachment
    }
    
    
    class func getDocType(pType : String) -> Doctype {
        var bReturnType : Doctype = .image
        switch pType {
            case "jpg", "png", "jpeg", "gif" :
                bReturnType = .image
            case "pdf" :
                bReturnType = .pdf
            case "flv", "mp4", "mov", "m4v", "wmv", "avi", "mpeg":
                bReturnType = .media
            case "doc", "docx", "txt", "rtf" :
                bReturnType = .doc
            case "pptx", "ppt", "csv", "pps", "xls", "xlsx" :
                bReturnType = .excel
            default:
                bReturnType = .doc
        }
                
        return bReturnType
    }
    
    class func isFileExist(pFileName : String) -> Bool {
        let paths = NSSearchPathForDirectoriesInDomains( .documentDirectory, .userDomainMask, true)[0] as String
        let path = paths.appending("/\(pFileName)")
        if FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }
    
    class func getFileUrlFromDocDirectory(pFileName : String) -> NSURL {
        let fileParts = pFileName.components(separatedBy: ".")
//        if let bPath = Bundle.main.url(forResource: fileParts[0], withExtension: fileParts[1]) {
//            if FileManager.default.fileExists(atPath: bPath.path) {
//                return bPath as NSURL
//            }
//        }
//        return Bundle.main.url(forResource: fileParts[0], withExtension: fileParts[1])! as NSURL
        
        
        let bUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let bUrl1 = bUrl.appendingPathComponent(pFileName)
        return bUrl1 as NSURL
        
    }
    
    class func getDestination(pFileName : String) -> DownloadRequest.DownloadFileDestination {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(pFileName)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        return destination
    }
    
    class func saveProfileImage(pFileName : String, pImage : UIImage) {
        Commons.showIndicator()
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        
        let bImage = Commons.ResizeImage(image: pImage, targetSize: CGSize(width: 200, height: 200))
        
        if let data = UIImageJPEGRepresentation(bImage, 0.8) {
            let filename = documentsDirectory.appendingPathComponent(pFileName+".jpg")
            try? data.write(to: filename)
            print("profile image saved")
        }
        
        Commons.hideIndicator()
        
    }
    
    class func setProfileImage(pImageView : UIImageView, pFileName : String) {
        if Commons.isFileExist(pFileName: pFileName+".jpg") {
            let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
            let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
            let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
            if let dirPath          = paths.first
            {
                let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(pFileName+".jpg")
                let image    = UIImage(contentsOfFile: imageURL.path)
                pImageView.image = image
                // Do whatever you want with the image
            }
        }
    }
    
    class func getUniqueStringId() -> String {
        return ProcessInfo.processInfo.globallyUniqueString
    }
    
    
    class func gotoDashBoard() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "DashboardNVC")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
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



