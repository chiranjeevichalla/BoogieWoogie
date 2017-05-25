//
//  FirstViewController.swift
//  Talkative Parents
//
//  Created by Basavaraj Kalaghatagi on 15/05/17.
//  Copyright © 2017 SGS. All rights reserved.
//

import UIKit
import CoreData

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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.sharedInstance._child.getName()
        // Do any additional setup after loading the view, typically from a nib.
        
        
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
    
    fileprivate func setUpSegmentControl() {
        thisUISegmentController.titles = ["School", "Admin"]
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
        let cell: NotificationTableViewCell = self.thisUINotificationsTV.dequeueReusableCell(withIdentifier: "NotificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        cell.thisUITitle.text = self.thisNotifications[indexPath.row].getSubject()
        
        cell.thisUISubTitle.text = self.thisNotifications[indexPath.row].getDisplayDate()
        
        if self.thisNotifications[indexPath.row].getDidRead() {
            cell.thisUINotificationImage.image = UIImage(named: "notificationRead")
        } else {
            cell.thisUINotificationImage.image = UIImage(named: "notificationUnread")
        }
        
        if self.thisNotifications[indexPath.row].hasAttachment() {
            cell.thisUIAttachmentImage.isHidden = false
        } else {
            cell.thisUIAttachmentImage.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //close
        self.updateNotification(pId: self.thisNotifications[indexPath.row].getId(), pStatus: "1")
        self.thisNotifications[indexPath.row]._didRead = true
        self.thisUINotificationsTV.reloadRows(at: [indexPath], with: .fade)
        self.thisUINotificationsTV.deselectRow(at: indexPath, animated: true)
        
        let bNotification = self.thisNotifications[indexPath.row]
        
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
    
    fileprivate func getNotifications(pIndex : Int) {
        if pIndex == 0 {
            if self.thisNotifications.count == 0 {
                getSchoolNotifications(pFromPage: self.thisNotifications.count)
            }
        } else {
            getAdminNotifications(pFromPage: 0)
        }
        
        self.thisUINotificationsTV.reloadData()
    }
    
    fileprivate func getSchoolNotifications(pFromPage : Int) {
        AppService.GetSchoolNotifications(pSchoolId: Constants.sharedInstance._child.getSchoolId(), pFromPageNumber: pFromPage) { (pNotifications, result) in
            if result {
                self.thisNotifications = pNotifications
                for bNotification in self.thisNotifications {
                    bNotification._didRead = self.didRead(pId: bNotification.getId())
                }
                self.thisUINotificationsTV.reloadData()
            }
        }
    }

    
    fileprivate func getAdminNotifications(pFromPage : Int) {
        AppService.GetAdminNotifications(pSchoolId: Constants.sharedInstance._child.getSchoolId(), pFromPageNumber: pFromPage) { (pNotifications, result) in
            if result {
//                self.thisNotifications = pNotifications
//                for bNotification in self.thisNotifications {
//                    bNotification._didRead = self.didRead(pId: bNotification.getId())
//                }
                self.thisUINotificationsTV.reloadData()
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
        self.getNotifications(pIndex: Int(sender.index))
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


}

