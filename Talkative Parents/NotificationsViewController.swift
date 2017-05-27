//
//  FirstViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 15/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import CoreData
import DZNEmptyDataSet
import CCBottomRefreshControl

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}

class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var thisUISegmentController: BetterSegmentedControl!
    
    @IBOutlet weak var thisUISegmentView: UIView!
    @IBOutlet weak var thisUINotificationsTV: UITableView!
    
    private var thisNotifications : [Notification] = []
    private var thisAdminNotifications : [Notification] = []
    //0-loading, 1-loaded, 2-error
     var isSchoolNotificationsLoaded = 0
     var isAdminNotificationsLoaded = 0
    let bRefreshControl = UIRefreshControl()
    private var thisSchoolNotificationPageNumber = 0
    private var thisAdminNotificationPageNumber = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.title = Constants.sharedInstance._child.getName()
        self.navigationItem.title = Constants.sharedInstance._child.getName()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.thisUINotificationsTV.emptyDataSetSource = self
        self.thisUINotificationsTV.emptyDataSetDelegate = self
        
        
        bRefreshControl.triggerVerticalOffset = 100
        self.thisUINotificationsTV.bottomRefreshControl = bRefreshControl
        bRefreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        
        self.thisUINotificationsTV.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
        self.thisUINotificationsTV.tableFooterView = UIView(frame: .zero)
        setUpSegmentControl()
        getSchoolNotifications(pFromPage: 0)
        thisUISegmentView.backgroundColor = Constants.sharedInstance.barColor
        thisUISegmentView.layer.shadowColor = UIColor.gray.cgColor
        thisUISegmentView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        thisUISegmentView.layer.shadowOpacity = 1.0
        thisUISegmentView.layer.shadowRadius = 0.0
        UIApplication.shared.statusBarView?.backgroundColor = Constants.sharedInstance.barColor
        thisUISegmentController.addTarget(self, action: #selector(self.navigationSegmentedControlValueChanged(_:)), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.backgroundColor = Constants.sharedInstance.barColor
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = Constants.sharedInstance.barColor
        UIApplication.shared.statusBarView?.backgroundColor = Constants.sharedInstance.barColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage =  nil
        UIApplication.shared.statusBarView?.backgroundColor = nil
    }
    
    func refresh() {
        bRefreshControl.endRefreshing()
        if self.thisUISegmentController.index == 0 {
            if self.isSchoolNotificationsLoaded == 1 {
                self.getSchoolNotifications(pFromPage: self.thisNotifications.count)
            }
            
        } else{
            if Constants.sharedInstance._UserDefaults.isAdminNotificationEnabled() {
                if self.isAdminNotificationsLoaded == 1 {
                   self.getAdminNotifications(pFromPage: self.thisAdminNotifications.count)
                }
                
            } else {
                
            }
        }
    }
    
    fileprivate func setUpSegmentControl() {
        thisUISegmentController.titles = ["School", "TP Admin"]
    }
    
    fileprivate func getNotificationByType(pRow : Int) -> Notification {
        if thisUISegmentController.index == 0 {
            return self.thisNotifications[pRow]
        } else {
            return self.thisAdminNotifications[pRow]
        }
        
    }
    
    //MARK: TableView Delegates and functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if thisUISegmentController.index == 0 {
            return thisNotifications.count
        }
        else {
            return thisAdminNotifications.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let bNotification = getNotificationByType(pRow: indexPath.row)
        
        let cell: NotificationTableViewCell = self.thisUINotificationsTV.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        cell.thisUITitle.text = bNotification.getSubject()
        
        cell.thisUISubTitle.text = bNotification.getDisplayDate()
        
        if bNotification.getDidRead() {
            cell.thisUINotificationImage.image = UIImage(named: "notificationRead")
        } else {
            cell.thisUINotificationImage.image = UIImage(named: "notificationUnread")
        }
        
        if bNotification.hasAttachment() {
            cell.thisUIAttachmentImage.isHidden = false
        } else {
            cell.thisUIAttachmentImage.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        let bNotification = getNotificationByType(pRow: indexPath.row)
        self.updateNotification(pId: bNotification.getId(), pStatus: "1")
        bNotification._didRead = true
//        self.thisNotifications[indexPath.row]._didRead = true
        self.thisUINotificationsTV.reloadRows(at: [indexPath], with: .fade)
        self.thisUINotificationsTV.deselectRow(at: indexPath, animated: true)
        
//        let bNotification = self.thisNotifications[indexPath.row]
        
        gotoNoticeBoardDetailPage(pNotification: bNotification)
    }
    
    fileprivate func gotoNoticeBoardDetailPage(pNotification : Notification) {
        var pVC : NotificeBoardDetailViewController!
        pVC = NotificeBoardDetailViewController(nibName: "NotificeBoardDetailViewController", bundle: nil)
        pVC.thisNotification = pNotification
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(pVC, animated: true)
    }

    
    //MARK: private functions
    
    fileprivate func getNotifications(pIndex : Int, pIsScrolling : Bool) {
        if pIndex == 0 {
            
            if pIsScrolling || self.isSchoolNotificationsLoaded != 1 {
                getSchoolNotifications(pFromPage: self.thisNotifications.count)
            }
            
        } else {
            if Constants.sharedInstance._UserDefaults.isAdminNotificationEnabled() {
                if pIsScrolling || self.isAdminNotificationsLoaded != 1 {
                    getAdminNotifications(pFromPage: self.thisAdminNotifications.count)
                }
            }
        }
        
        self.thisUINotificationsTV.reloadData()
    }
    
    fileprivate func getSchoolNotifications(pFromPage : Int) {
        AppService.GetSchoolNotifications(pSchoolId: Constants.sharedInstance._child.getSchoolId(), pPageNumber: self.thisSchoolNotificationPageNumber) { (pNotifications, result) in
            
            if result {
                self.thisSchoolNotificationPageNumber = self.thisSchoolNotificationPageNumber + 1
                self.isSchoolNotificationsLoaded = 1
                for bNotification in pNotifications {
                    bNotification._didRead = self.didRead(pId: bNotification.getId())
                    self.thisNotifications.append(bNotification)
                }
                if self.thisNotifications.count > 0 {
                    if pNotifications.count == 0 {
                        Commons.showErrorMessage(pMessage: "No more Notifications")
                    }
                }

                self.thisUINotificationsTV.reloadData()
            } else {
                self.isSchoolNotificationsLoaded = 2
            }
        }
    }

    
    fileprivate func getAdminNotifications(pFromPage : Int) {
        AppService.GetAdminNotifications(pSchoolId: Constants.sharedInstance._child.getSchoolId(), pPageNumber: self.thisAdminNotificationPageNumber) { (pNotifications, result) in
            
            if result {
                self.thisAdminNotificationPageNumber = self.thisAdminNotificationPageNumber + 1
                self.isAdminNotificationsLoaded = 1
                for bNotification in pNotifications {
                    bNotification._didRead = self.didRead(pId: bNotification.getId())
                    self.thisAdminNotifications.append(bNotification)
                }
                if self.thisAdminNotifications.count > 0 {
                    if pNotifications.count == 0 {
                        Commons.showErrorMessage(pMessage: "No more Notifications")
                    }
                }
//                self.thisNotifications = pNotifications
//                for bNotification in self.thisNotifications {
//                    bNotification._didRead = self.didRead(pId: bNotification.getId())
//                }
                self.thisUINotificationsTV.reloadData()
            } else {
                self.isAdminNotificationsLoaded = 2
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func didRead(pId: String) -> Bool {
        return CoreDataManager.didRead(pId:pId)
    }
    
    func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        self.getNotifications(pIndex: Int(sender.index), pIsScrolling: false)
        if sender.index == 0 {
            print("Turning lights on.")
            
        }
        else {
            print("Turning lights off.")
            
        }
    }
    
    fileprivate func updateNotification(pId: String, pStatus : String) {
        CoreDataManager.setRead(pId: pId, pDidRead: true)
    }
//    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let contentHeight = scrollView.contentSize.height
//        
//        if offsetY > contentHeight - scrollView.frame.size.height {
//            
//            print("over bottom scroll")
//        }
//    }

}

extension NotificationsViewController : DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var str = ""
        if self.thisUISegmentController.index == 0 {
            if self.isSchoolNotificationsLoaded == 0 {
                str = "Loading"
            }
            else if self.isSchoolNotificationsLoaded == 1 {
                str = "No Notifications Found"
            } else {
                str = "Error"
            }
        } else{
            if Constants.sharedInstance._UserDefaults.isAdminNotificationEnabled() {
                if self.isAdminNotificationsLoaded == 0 {
                    str = "Loading"
                }
                else if self.isAdminNotificationsLoaded == 1 {
                    str = "No Notifications Found"
                } else {
                    str = "Error"
                }
            } else {
                str = "Get Admin Notifications"
            }
        }
        
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        var str = "Tap the Camera button to add new bill."
        if self.thisUISegmentController.index == 0 {
            if self.isSchoolNotificationsLoaded == 0 {
                str = "Please wait while loading"
            }
            else if self.isSchoolNotificationsLoaded == 1 {
                str = "No School Notifications Found"
            } else {
                str = "Something went wrong Please Tap to reload"
            }
        } else{
            if Constants.sharedInstance._UserDefaults.isAdminNotificationEnabled() {
                if self.isAdminNotificationsLoaded == 0 {
                    str = "Please wait while loading"
                }
                else if self.isAdminNotificationsLoaded == 1 {
                    str = "No Admin Notifications Found"
                } else {
                    str = "Something went wrong Please Tap to reload"
                }
            } else {
                str = "Would you like to get Notifications ? then tap to reload"
            }
        }
        let attrs = [NSFontAttributeName: UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
//    func buttonTitle(forEmptyDataSet scrollView: UIScrollView, for state: UIControlState) -> NSAttributedString? {
//        var str = ""
//
//        return NSAttributedString(string: str, attributes : nil)
//    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap view: UIView!) {
        if self.thisUISegmentController.index == 0 {
            if self.isSchoolNotificationsLoaded == 2 {
               self.getSchoolNotifications(pFromPage: 0)
            }
            
        } else{
            if Constants.sharedInstance._UserDefaults.isAdminNotificationEnabled() {
                if self.isAdminNotificationsLoaded == 2 {
                    self.getAdminNotifications(pFromPage: 0)
                }
                
            } else {
                Constants.sharedInstance._UserDefaults.setAdminNotificationEnabled()
                self.getAdminNotifications(pFromPage: 0)
            }
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView, didTap button: UIButton) {
//        if self._historyType == 0 {
//            
//        }
        
    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return false
    }
    
}

